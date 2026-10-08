# Configuration

Go to **Configuration → Web services → GPT Code Reviewer**
(`/admin/config/services/gpt_code_reviewer/settings`). You need the **Administer
GPT code reviewer** permission (`administer gpt_code_reviewer`).

## The settings form, field by field

- **GPT Code Reviewer API server** — the URL the module POSTs code to. This is the
  separate GPT API server you run; it relays the request to OpenAI. Set it to your
  own server's address and make sure it is reachable from the Drupal site.
- **OpenAI API key** — required. **Please read the security note below** before
  entering it.
- **Model** — which OpenAI model to use: `gpt-3.5-turbo`, `gpt-4` or
  `gpt-4-turbo`. More capable models cost more per call.
- **Timeout** — the request timeout in seconds, between **600 and 1800**. Code
  reviews can take a while, so the allowed range is deliberately long.

## Security note: the API key is stored in plaintext

This module stores the OpenAI API key in **plain configuration**
(`gpt_code_reviewer.settings:openai_api_key`) and renders it in a plain text field
on this form. It does **not** integrate with the Key module, so:

- **Anyone who can open this settings page can read the key.** Grant the
  `administer gpt_code_reviewer` permission only to people you trust with the key.
- Because the value lives in configuration, be careful not to commit it to version
  control through exported config. If you keep the key in your environment (for
  example via `ddev dotenv set .ddev/.env --openai-api-key=<value>` and then
  `ddev restart`), avoid exporting the populated setting into your config sync
  directory.
- Treat the settings page as **secret‑bearing** in your operational procedures.

The request itself goes to the admin‑configured server URL over Guzzle with TLS
verification left at its (enabled) default — so keep the server on `https://`.

## Cost and egress control

Every review is an **outbound call to a paid LLM endpoint**, so creating reviews
spends money and sends the submitted code off your server to the configured API.
Control this through permissions:

- **`add gpt_code_reviewer review`** — allows creating a review (i.e. triggering a
  paid call). It is **off for anonymous users by default**, so there is no
  anonymous cost‑abuse path out of the box. Grant it only to trusted roles.
- **`view gpt_code_reviewer review`** — who can read stored reviews.
- **`edit` / `delete` / `list gpt_code_reviewer review`** — the remaining
  operations on Review entities.

Grant `add` narrowly to avoid uncontrolled API spend, and remember that the code
submitted for review leaves your site — don't submit anything you're not
comfortable sending to the configured server and OpenAI.
