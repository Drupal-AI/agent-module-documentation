# Configuration

Chatbot Lite's behaviour is defined entirely on one settings form. Open it at
**Configuration → System → Chatbot Lite**
(`/admin/config/system/chatbot_lite`, route `chatbot_lite.settings`). You need the
**Administer site configuration** permission. Settings are saved to the
`chatbot_lite.settings` configuration object.

The bot answers a question by trying, in order: your configured Q&A pairs, then a
node‑title search, then the fallback answer. The fields below control each step.

## Question / answer pairs

Enter your FAQ as `question|answer`, one pair per line — the question and its answer
separated by a pipe (`|`). When a visitor's question matches, the corresponding
answer is returned. This is the bot's primary knowledge source.

## Searchable content types

Choose which content types the bot may search when no Q&A pair matches. The bot
runs a "title contains" search across nodes of these types (limited to a handful of
results) and returns matches as links. The search honours Drupal's node access
grants, so visitors only see content they're already permitted to view.

## Fallback ("nothing found") answer

The message the bot returns when neither a Q&A pair nor a node‑title search turns
anything up. Write something helpful that points the visitor to another route
(a contact form, a search page, and so on).

## Words to ignore

A list of words the bot strips out of the visitor's question before matching (common
filler words, for example). This helps the keyword matching focus on the meaningful
terms.

## Save

Save the form. Changes take effect immediately — open the chat form at
`/chatbot_lite_form` and try a question to confirm the bot responds as expected.
