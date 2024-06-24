const fs = require('fs');

// Načtení aktualizovaného json
let data = require('./data.json');

// Načtení pravidel pro slovesa a slova
const verbsRules = data.rules.verbsRules;
const wordsRules = data.rules.wordsRules;

// Funkce pro přidání klíčů 'level' a 'id' do každé položky podle typu
function updateVerbsWithRules(data, rules) {
    //nastav verbs nebo words
    data.type.verbs = data.type.verbs.map((item, index) => {
        const level = rules[item.level - 1].level;
        return {
            ...item,
            level,
            id: index,
        };
    });
}

// Použití funkce updateVerbsWithRules pro přidání klíčů 'level' a 'id' do sloves nebo slov
updateVerbsWithRules(data, verbsRules);

// Funkce pro přidání nových slovíček (sloves) do seznamu
function addNewVerbs(newVerbs) {
    const lastId = data.type.verbs[data.type.verbs.length - 1].id;
    let nextId = lastId + 1;

    newVerbs.forEach(verb => {
        data.type.verbs.push({
            ...verb,
            level: 1,
            id: nextId++
        });
    });
}

// Načtení nových dat ze souboru newData.json
const newData = require('./newData.json');

// Použití funkce addNewVerbs pro přidání nových slovíček z načtených dat
addNewVerbs(newData);

// Převedení na json
const jsonData = JSON.stringify(data, null, 2);

// Uložení
fs.writeFileSync('./data2.json', jsonData);