import pyperclip

import deepl

 

# tanslation

translator = deepl.Translator("06116763-fb13-0f8f-33f2-92f4f41a77ad:fx") #https://www.deepl.com/nl/docs-api/accessing-the-api/

# paste text from clipboard

txtContent = pyperclip.paste()

# split txtContent into chunks < 5K

chunks = txtContent.split('\n')

chunks = list(filter(None,chunks))

chunks = [j.strip() for j in chunks]

chunks = list(filter(None,chunks))

chunksTranslated = []

# translate chunks and concatenate to textTranslation

for chunk in chunks:

    chunkTranslation = translator.translate_text(chunk, target_lang = "FR")

    chunksTranslated.append(chunkTranslation.text)

textTranslation = '\n'.join(chunksTranslated)

# copy translation to clipboard

pyperclip.copy(textTranslation)

 