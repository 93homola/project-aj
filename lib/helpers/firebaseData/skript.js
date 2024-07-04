const fs = require('fs');

// Cesta k souboru
const filePath = 'data_from_firebase.json';

// Nová slovíčka k přidání
const newItems = [
    ["žalovat", "sue"]
];

// Načtení existujících dat
fs.readFile(filePath, 'utf8', (err, data) => {
    if (err) {
        console.error(err);
        return;
    }
    const jsonData = JSON.parse(data);

    // Získání nejvyššího ID
    let maxId = jsonData.verbs.reduce((max, item) => item.id > max ? item.id : max, 0);

    // Přidání nových slovíček
    newItems.forEach(([cs, en]) => {
        maxId++;
        const newItem = {
            cs,
            en,
            id: maxId,
            level: 1,
            type: "verb"
        };
        jsonData.verbs.push(newItem);
    });

    // Uložení upravených dat zpět do souboru
    fs.writeFile(filePath, JSON.stringify(jsonData, null, 4), 'utf8', (err) => {
        if (err) {
            console.error(err);
        }
    });
});