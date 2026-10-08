# Configuration

Project Browser AI needs an **AI provider** and an **API key** so it can turn a
natural-language query into relevant module suggestions. The provider and keys are
admin-configured, and — importantly — the keys should be **env-backed** rather than
typed into committed configuration.

## Connect an AI provider

Configure the AI provider and model the module should use for smart search, along
with the API key it authenticates with. In the Drupal AI ecosystem these
credentials are typically held as a **Key** entity backed by an environment
variable, rather than pasted into a plain settings field — so the secret never ends
up in your configuration export or repository.

## Store the API key as a secret

Never hard-code or commit an AI provider API key. Store it in an environment
variable and reference it through a Key entity. With DDEV, for example:

```bash
ddev dotenv set .ddev/.env --pb-ai-api-key=<value>
ddev restart
```

(Keep `.ddev/.env` out of version control.) Confirm the variable is present in the
container **without printing its value** (`ddev exec 'test -n "$PB_AI_API_KEY"'` —
exit status 0 means it is set), then wire it up through a Key entity using the
built-in environment provider so Drupal reads the value at runtime.

## Understand egress and cost

Because smart search is powered by an LLM, be aware of two practical consequences:

- **Data egress** — each smart search sends the user's query (and related module
  metadata) to your chosen AI provider over the network. Make sure that is
  acceptable for your site's privacy posture.
- **Cost** — each search can be a billable API call to the provider. On a busy site
  the number of calls (and the bill) grows with usage, so keep an eye on your
  provider's usage dashboard, especially while this beta module is in trial use.

## Test

After connecting a provider, open the Project Browser and run a natural-language
search. If results come back that match the intent of your query, the integration
is working. If searches fail, re-check that the API key is set and readable and
that your provider account has quota.
