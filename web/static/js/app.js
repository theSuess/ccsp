// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html";

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

var simplemde;
var aceeditor;
if (document.querySelector('#content-editor')) {
    simplemde = new SimpleMDE({
        element: document.querySelector('#content-editor')
    });
}
if (document.querySelector('#code-editor')) { // Code editor page is shown
    ace.require("ace/ext/language_tools");
    aceeditor = ace.edit('code-editor');
    aceeditor.setFontSize(17);
    aceeditor.getSession().setMode(`ace/mode/${document.querySelector('#lang-select').value.toLowerCase()}`);
    aceeditor.setTheme(`ace/theme/${document.querySelector('#theme-select').value.toLowerCase()}`);
    aceeditor.setOptions({
        enableBasicAutocompletion: true,
        enableSnippets: true,
        enableLiveAutocompletion: true
    });

    aceeditor.getSession().setMode('ace/mode/csharp');
    var langselect = document.querySelector('#lang-select');
    var themeselect = document.querySelector('#theme-select');
    var runbutton = document.querySelector('#run-button');

    langselect.onchange = () => {
        var lang = langselect.options[langselect.selectedIndex].dataset.ace;
        console.log(lang);
        aceeditor.getSession().setMode(`ace/mode/${lang}`);
    };
    themeselect.onchange = () => {
        aceeditor.setTheme(`ace/theme/${themeselect.value.toLowerCase()}`);
    };
    runbutton.onclick = () => {
        runbutton.classList.toggle('is-loading');
        var lang = langselect.value;
        var content = aceeditor.getValue();
        var program = {
            program: {
                language: lang + '/latest',
                content: content,
                extension: getExtension(lang)
            }
        };
        fetch('/api/run', {
                'method': 'post',
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(program)
            })
            .then((data) => data.json())
            .then((data) => {
                runbutton.classList.toggle('is-loading');
                console.log(data);
                document.querySelector('#output').value = '';
                document.querySelector('#output').value = data.stdout + '\n' + data.stderr;
            });
    };
}

function getExtension(lang) {
    switch (lang) {
        case 'assembly':
            return 'asm';
        case 'bash':
            return 'sh';
        case 'clojure':
            return 'clj';
        case 'coffescript':
            return 'coffee';
        case 'crystal':
            return 'cr';
        case 'csharp':
            return 'cs';
        case 'd':
            return 'd';
        case 'elixir':
            return 'ex';
        case 'erlang':
            return 'erl';
        case 'fsharp':
            return 'fs';
        case 'go':
            return 'go';
        case 'groovy':
            return 'groovy';
        case 'haskell':
            return 'hs';
        case 'idris':
            return 'idr';
        case 'java':
            return 'java';
        case 'javascript':
            return 'js';
        case 'julia':
            return 'jl';
        case 'kotlin':
            return 'kt';
        case 'lua':
            return 'lua';
        case 'mercury':
            return 'm';
        case 'nim':
            return 'nim';
        case 'ocaml':
            return 'ml';
        case 'perl':
            return 'pl';
        case 'perl6':
            return 'pl6';
        case 'php':
            return 'php';
        case 'python':
            return 'py';
        case 'ruby':
            return 'rb';
        case 'rust':
            return 'rs';
        case 'scala':
            return 'scala';
        case 'swift':
            return 'swift';
        case 'typescript':
            return 'ts';

    }
}
