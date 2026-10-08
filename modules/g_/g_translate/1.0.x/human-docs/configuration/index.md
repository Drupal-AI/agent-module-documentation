# Configuration

GTranslate is configured in two steps: adjust its settings form, then place the
translation block where visitors will see it.

## Open the settings form

1. Log in as a user with the **Administer site configuration** (or the module's
   `g_translate settings`) permission.
2. Go to **Configuration → Regional and language → GTranslate**, or navigate
   directly to `/admin/config/regional/g-translate`.

Here you control how the Google Translate widget behaves and appears — the widget
style/layout and which languages are offered. Adjust these to taste; the sensible
starting point is to keep the language list short and relevant to your actual
audience rather than offering every possible language.

## A note on identifiers vs. secrets

The basic Google Translate widget runs in the visitor's browser and does **not**
require an API key, so there is nothing secret to store for it. If you extend to a
paid Google Cloud Translation setup that needs a real API key, that key **is** a
secret — never hard‑code or commit it. Store it in an environment variable (with
DDEV, `ddev dotenv set`) and reference it through a **Key** entity rather than
pasting it into a config field. A site/tracking identifier, by contrast, is
configuration, not a secret.

## Place the translation block

The language selector is delivered as a block:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** on the region where the selector should appear (a header
   or footer is common).
3. Find the **GTranslate** block, place it, set any visibility conditions, and
   save.

## Save and privacy note

Click **Save configuration** on the settings form, and **Save block** after
placing the block. Reload a front‑end page to confirm the selector appears.

Remember that the widget loads a **third‑party Google script** that sees every
page a visitor reads. Make sure that fits your privacy/consent policy, and if you
enforce a Content‑Security‑Policy, allow Google's translate hosts so the widget is
not blocked.
