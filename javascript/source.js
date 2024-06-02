const axios = require("axios");

const apiKey = process.env.TRELLO_API_KEY;
const token = process.env.TRELLO_TOKEN;
const boardId = "VXTmT8pZ";
const getListsInBoard = async () => {
  const url = `https://api.trello.com/1/boards/${boardId}/lists`;

  const response = await axios.get(url, {
    params: {
      key: apiKey,
      token: token,
    },
  });
  return response.data;
};

getListsInBoard();
const getCardsInList = async (listId) => {
  const url = `https://api.trello.com/1/lists/${listId}/cards`;

  const response = await axios.get(url, {
    params: {
      key: apiKey,
      token: token,
    },
  });
  return response.data;
};

const getMemberDetails = async (memberId) => {
  const url = `https://api.trello.com/1/members/${memberId}`;

  const response = await axios.get(url, {
    params: {
      key: apiKey,
      token: token,
      fields: "fullName,username",
    },
  });
  return response.data;
};

const getCardsWithDetails = async (listId) => {
  const cards = await getCardsInList(listId);
  const cardDetails = await Promise.all(
    cards.map(async (card) => {
      const members = await Promise.all(
        card.idMembers.map((memberId) => getMemberDetails(memberId))
      );

      const cardStatus = card.due
        ? new Date(card.due) < new Date()
          ? "Overdue"
          : "On Time"
        : "No Deadline";
      const completedOnDeadline =
        card.dueComplete && new Date(card.dueComplete) <= new Date(card.due);

      return {
        ...card,
        members: members,
        status: cardStatus,
        completedOnDeadline: completedOnDeadline,
      };
    })
  );
  return cardDetails;
};

const fetchBoardData = async () => {
  try {
    const lists = await getListsInBoard();

    const listsWithCards = await Promise.all(
      lists.map(async (list) => {
        const cards = await getCardsWithDetails(list.id);
        return {
          ...list,
          cards: cards,
        };
      })
    );

    console.log(JSON.stringify(listsWithCards, null, 2));
  } catch (error) {
    console.error(error);
  }
};

fetchBoardData();
