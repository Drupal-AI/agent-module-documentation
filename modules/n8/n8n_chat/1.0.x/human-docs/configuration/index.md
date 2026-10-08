# Configuration

The core of setting up n8n Chat is telling Drupal **where your n8n workflow
lives** (its chat webhook URL) and **how the widget should appear**. You do this
in the module's settings, and — if you want targeted placement rather than a
site‑wide widget — in the Block layout.

## Before you start: get your n8n webhook URL

In your n8n instance, build (or open) the chat workflow you want to expose and
copy its **chat webhook URL**. This is the endpoint the widget posts visitor
messages to. Keep it handy; you will paste it into Drupal next.

## The webhook URL

The most important setting is the **n8n webhook URL**. Paste the URL you copied
from n8n here. Everything a visitor types is sent to this endpoint, so:

- Use an **HTTPS** URL, never plain HTTP.
- Point it only at an n8n instance you trust and control.
- Make sure the workflow behind it does not expose data or actions it should not.

## Widget appearance and behavior

The settings let you tune how the chat presents itself:

- **Theme** — choose a light or dark appearance to match your site.
- **Custom CSS** — supply your own styles for finer control over the widget's look.
- **Session behavior** — the widget automatically assigns each visitor a unique
  session ID and keeps the conversation for roughly 24 hours, so a reload does not
  lose context. Visitors can also start a fresh conversation at any time.
- **User context (optional)** — you can choose to share information about the
  logged‑in user with the n8n workflow. Only enable this if your workflow needs
  it and you are comfortable with that data leaving your site.

## Global widget vs. block placement

You have two ways to show the chat:

- **Global widget** — turn this on to display the chat site‑wide without touching
  Block layout.
- **Block placement** — leave the global widget off and instead place the **n8n
  Chat** block in a specific region through **Structure → Block layout**, where
  you can scope it to particular pages, content types, or roles using the normal
  block visibility settings.

## Handling secrets safely

If your n8n workflow expects a secret (an API key, token, or signed header) to
authenticate incoming chat requests, do **not** hard‑code or commit it. Store it
in an environment variable and reference it from Drupal — for example, with DDEV:

```bash
ddev dotenv set .ddev/.env --n8n-webhook-secret=<value>
ddev restart
```

Then consume the value from an environment variable (or a Key entity, if you use
the [Key](https://www.drupal.org/project/key) module) rather than pasting it into
a plaintext field or committing it to your repository. Keep `.ddev/.env` out of
version control.

## Save and test

Save your settings, then load a page where the widget should appear. Type a
message and confirm it reaches your n8n workflow (check the workflow's execution
log in n8n) and that the reply comes back into the widget.
