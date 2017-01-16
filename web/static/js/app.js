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
if(document.querySelector('#content-editor')){
    simplemde = new SimpleMDE({element:document.querySelector('#content-editor')});
}
if(document.querySelector('#code-editor')){ // Code editor page is shown
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

    langselect.onchange = () => {
        aceeditor.getSession().setMode(`ace/mode/${langselect.value.toLowerCase()}`);
    };
    themeselect.onchange = () => {
        aceeditor.setTheme(`ace/theme/${themeselect.value.toLowerCase()}`);
    };
    document.querySelector('#run-button').onclick = () => {
        console.log(langselect.value);
        console.log(aceeditor.getValue());
    };
}
