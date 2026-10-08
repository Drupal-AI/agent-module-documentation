# Configuration

All of Knova's setup happens on one page: **Configuration → Services → Knova
Settings**. You need the **Administer site configuration** permission (an
administrator by default) to reach it. The steps below follow the module's own
post‑installation checklist.

## Store the OpenAI API key securely (recommended)

Knova authenticates to OpenAI with an API key, and every chat turn spends credits
against it — so treat the key as a secret. Rather than pasting it straight into
the form (where it can end up in a configuration export and in git), store it in
an environment variable and reference it from Drupal.

With DDEV, save it into the project's dotenv file and restart so the container
picks it up:

```bash
ddev dotenv set .ddev/.env --openai-api-key=<your-key>
ddev restart
```

That makes the value available as `OPENAI_API_KEY` inside the container. Never
commit `.ddev/.env`. Where the module accepts a
[Key](https://www.drupal.org/project/key) entity, create one backed by that
environment variable and select it here; otherwise reference the variable from
`settings.php` with `getenv('OPENAI_API_KEY')`.

## Work through the settings

On the **Knova Settings** page:

1. **Enable the chatbot widget** — the master switch that makes the widget appear
   on front‑end pages.
2. **Widget position** — choose **left** or **right** for the corner the chat icon
   sits in.
3. **Appearance** — set colours, logo, size, and the widget's text/branding so it
   matches your site.
4. **OpenAI API key** — enter the key (or the Key/environment reference you set up
   above). This authenticates every request to OpenAI.
5. **AI model and basic settings** — select the OpenAI model to use and any basic
   behaviour options.
6. **Rate limiting** — set the limits that cap how many API calls the widget can
   make. Because each chat turn costs OpenAI credits and sends visitor input to
   OpenAI, treat this as a cost‑ and abuse‑control setting, not an optional extra.

Save the form.

## Train the bot with Q&A pairs

Add a few **question‑and‑answer pairs** based on your site's content, services, or
products. Each pair has:

- a **question**,
- an **answer**, and
- optionally a **related page URL** the bot can include in its reply.

The chatbot uses these pairs to keep its answers accurate and grounded in your
own content. Start with your most common questions and add more over time.

## A note on data and cost

Every visitor message is sent to OpenAI to generate a reply, and each reply spends
credits. Keep the rate limits sensible, monitor your OpenAI usage, and consider
disclosing in your privacy policy that chat input is processed by a third‑party AI
service.
