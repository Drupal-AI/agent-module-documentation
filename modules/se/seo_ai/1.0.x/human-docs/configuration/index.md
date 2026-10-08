# Configuration

SEO AI does nothing until you tell it which AI service to call and which content
types should show the **Generate Metatags** button. All of that lives on one
settings form.

## Open the settings form

1. Log in as a user with the **Administer SEO AI** (`administer seo ai`)
   permission — this is a restricted permission, so grant it only to trusted
   roles.
2. Go to **Configuration → Search and metadata → SEO AI**, or navigate directly
   to `/admin/config/content/seo-ai`.

## The settings, field by field

- **Endpoint** — the URL of your OpenAI-compatible chat completions API. This is
  set here by an administrator (never taken from a visitor), so point it at a
  service you trust. The connection uses normal TLS verification.
- **Model** — the model name to request from that endpoint (for example a
  GPT-class chat model your provider offers).
- **API token** — the secret token used to authenticate with the endpoint. Be
  aware this value is stored in the module's configuration in plain text, so
  keep your exported config and database access restricted.
- **Max tokens** — the ceiling on how large a response the module asks the model
  to return.
- **Temperature** — how creative versus deterministic the suggestions are; lower
  values give steadier, more predictable output, higher values more varied.
- **Enabled content types** — tick the content types on which the **Generate
  Metatags** button should appear. The button only shows on a chosen type *and*
  only when that type has a Metatag field. The module also limits how much of the
  page text it sends by a maximum context length.

## Save

Save the form. Then edit a node of one of the enabled content types: the
**Generate Metatags** button will be on the form, and clicking it fills the
Metatag basic and Open Graph fields (title, description, abstract, keywords, OG
title and description) with the model's suggestions for you to review and save.
