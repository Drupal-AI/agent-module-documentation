# Configuration

Once the module is installed, its configuration page is where you connect your AI
account and choose which languages to translate into. After that, you generate
translations and copy them where you need them.

## Handle the API key as a secret

Your OpenAI (or Azure OpenAI) API key is a credential that can run up charges, so
keep it out of version control and serve your site over HTTPS. If you run DDEV, a
clean pattern is to store the value in the environment and never commit
`.ddev/.env`:

```bash
ddev dotenv set .ddev/.env --openai-api-key=sk-...
ddev restart
```

You then supply the key on the module's configuration page.

## On the configuration page

Open the module's configuration page (linked from the module's row on the Extend
page, or under **Configuration**). There you can:

- **Connect to your OpenAI or Azure OpenAI account** — enter the API key (and, for
  Azure OpenAI, the endpoint/deployment details Azure requires) so the module can
  reach the translation service.
- **Select the languages** you want translations for, from the list of languages
  enabled on your site. You can enable all of them or just the ones you need.

Save the form.

## Generate and use translations

With the account connected and languages chosen, generate translations for your
content — in bulk for all enabled languages, or for the specific ones you picked —
then use the **copy** feature to paste each translation into the right place on
your site.

## Review before publishing

The toolbox is built around a copy‑and‑paste workflow precisely so a human stays
in the loop. Read every generated translation before it goes live, and be mindful
of the content you send to OpenAI (avoid sending unnecessary personal data) and of
the per‑translation cost.
