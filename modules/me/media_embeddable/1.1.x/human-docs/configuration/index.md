# Configuration

Media: Embeddable has a small settings form, but the single most important part of
configuring it is **not on that form** — it is deciding who is allowed to create
embeddable media. Read the permission section first.

## Lock down who may create embeddable media

An embeddable media item stores a block of arbitrary HTML, and arbitrary HTML is
arbitrary JavaScript. Whoever can create these entities can run code in the
browser of every visitor to every page that references them, and — unlike markup
pasted into a body field — it does **not** pass through a text format's filtering.
That is effectively the ability to deploy code.

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Find **`administer media embeddable`** (the module marks it as an
   access‑restricted permission for exactly this reason).
3. Grant it only to the small set of trusted, administrative roles you would
   already trust to deploy code. Do not give it to general content editors.

## Open the settings form

1. Log in as a user with permission to administer the site.
2. Go to the module's settings page under **Configuration → Media** — the
   `media_embeddable.settings` route, documented by the project at
   `/admin/config/media_embeddable`.

This form holds the module's own options for how embeddable media behaves. Adjust
the values to suit your site and click **Save configuration**; the settings take
effect immediately. If you are unsure what a given option does, the safe default
is to leave it as shipped — the security decision above matters far more than any
of these settings.

## A note on privacy and consent

Every third‑party embed loads a provider's script, and that script sees every
visitor to the page. Treat embeddable media the same way you treat an analytics
or marketing tag: if your site uses a consent manager, the embed belongs behind
it.
