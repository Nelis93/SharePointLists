import pyperclip

import re


# paste text from clipboard

txtContent = pyperclip.paste()

# split txtContent into chunks

chunks = txtContent.split('\n')

# search for times in chunks

reg = re.compile("\d{2}[:]\d{2}[:]\d{2}")

timesinchunks = list(filter(reg.match, chunks))

# get texts in chunks

textinchunks = [x for x in chunks if x not in timesinchunks]

# put times in right format

timesinchunks_cleaned = [timesinchunk.replace("\r", ".000") for timesinchunk in timesinchunks]

# get endtimes

endtimes = timesinchunks_cleaned[1:]

endtimes.append(timesinchunks_cleaned[-1])

 

# Correct chunks with starttime == endtime

todelete = []

for i in range(len(timesinchunks_cleaned)-1):

    if timesinchunks_cleaned[i] == endtimes[i]:

        timesinchunks_cleaned[i+1] = timesinchunks_cleaned[i]

        textinchunks[i+1] = textinchunks[i] + "\n" + textinchunks[i+1]

        todelete.append(i)

timesinchunks_cleaned = [i for j, i in enumerate(timesinchunks_cleaned) if j not in todelete]

endtimes = [i for j, i in enumerate(endtimes) if j not in todelete]

textinchunks = [i for j, i in enumerate(textinchunks) if j not in todelete]

 

# create one obeject with start times, end times and texts

inputvtt = list(zip(timesinchunks_cleaned, endtimes, textinchunks))

 

# https://webvtt-py.readthedocs.io/en/latest/usage.html

from webvtt import WebVTT, Caption

 

vtt = WebVTT()

 

for item in inputvtt:

    # creating a caption with a list of lines

    caption = Caption(

        item[0],

        item[1],

        item[2])

    # adding a caption

    vtt.captions.append(caption)

 

# save to a file

vtt.save('ProcMod_Temp_Subs.vtt')