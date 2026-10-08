# Configuration

This module has no standalone settings page. You configure it through the **Copilot
transform** on an import pipeline in **LocalGov Publications Importer** — either the
bundled **`copilot_pipeline`** or a pipeline of your own that includes the
`transform_copilot_aio` step. First, though, you need a Copilot Studio bot to talk
to.

## 1. Provision the Copilot Studio bot

The module ships a **Copilot Studio Agent Solution** package (a zip). Import it into
Microsoft **Copilot Studio** to create the companion agent — it is pre‑built to
accept your document content and return the paginated JSON the module expects. Once
the agent exists, set up a **Direct Line** channel for it and note the endpoint that
issues Direct Line **tokens**; that URL is what you give the module below.

## 2. Configure the Copilot transform

Edit the Copilot transform on your import pipeline and set:

- **Token URL** *(required)* — the URL that returns a Direct Line token for your
  bot. If this is left empty the plugin logs an error ("Token URL must be
  configured for the transform plugin.") and the import aborts, so this is the one
  setting you must provide.
- **Direct Line base URL** — the Direct Line API base; defaults to
  `https://directline.botframework.com/v3/directline`. Change it only if you use a
  regional or alternative Direct Line endpoint.
- **Poll timeout** — how many seconds the module waits for the bot's reply before
  giving up (default **240**). Long publications can take a while to generate, so
  raise this if large documents time out.
- **Trigger phrase** — the phrase used to route the request to the right topic in
  your Copilot agent (default `drupal-pdf-importer`). Keep it in step with the
  bundled agent unless you have customised the bot.
- **Prompt** — the instructions sent to the agent. The default asks for *only* a
  JSON array of `{title, content}` page objects, roughly 200–500 words each, using a
  restricted set of HTML tags (`h1`–`h6`, `p`, `ul`, `ol`, `li`, `img`) with images
  preserved. Adjust it if you need different pagination or formatting, but keep the
  JSON‑array contract the save step relies on.

## 3. Run an import

Upload a PDF at **Content → Imports**, choose the Copilot pipeline, and process it on
cron or with `drush lpii`. At run time the module fetches a Direct Line token from
your **Token URL**, opens a conversation, posts the extracted content with your
prompt and trigger phrase, and polls for the JSON reply, which it saves as the
publication's pages.

## Security, cost and privacy

- **Your document content leaves your site.** The extracted text and HTML are sent
  to Microsoft's Direct Line endpoint (the configured Copilot agent). Treat this as
  a third‑party data‑processing arrangement: review the privacy implications and your
  organisation's data‑processing agreements before importing sensitive or
  not‑yet‑published documents.
- **Cost.** Copilot Studio usage is billed by Microsoft, and long documents mean
  larger requests and longer generations — factor this into how much you import.
- **Transport is secure.** All calls are made over HTTPS with normal TLS
  verification, and the Direct Line token is sent as a standard `Authorization:
  Bearer` header. The token URL, base URL and prompt are administrator‑supplied
  pipeline configuration, not request input, and the module exposes no routes or
  public endpoints of its own — it runs only as part of an operator‑triggered
  import. Protect the token endpoint and any credentials it depends on as you would
  any other secret.
