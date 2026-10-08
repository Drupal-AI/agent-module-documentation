# Configuration

Copyscape needs configuring before it can do anything: it has to know your
Copyscape account details, and which fields it should check. Configuration happens
in two places under **Configuration → Copyscape**.

## 1. Enter your account details

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Copyscape** (`/admin/config/copyscape/settings`).
3. Enter the **Copyscape account details** — the API username and API key from your
   paid Copyscape subscription. (If you followed the installation guide and stored
   the key as an environment variable or a Key entity, reference it here rather
   than pasting the raw value where your workflow supports it.)
4. Save.

Without valid credentials the module cannot contact the Copyscape API, so this
step is essential.

## 2. Choose which content and fields to check

1. Go to `/admin/config/copyscape/settings/content` (the **content** tab of the
   Copyscape settings).
2. Tick the content‑type fields you want added to the plagiarism‑check list. You
   can select as many content types and fields as you like, but only **long text**
   fields are available — Copyscape checks bodies of text, not short titles or
   plain values.
3. Save.

From this point on, every node that is added or edited is tested against the
Copyscape API for the selected fields — unless the editing user is allowed to
bypass the check.

## Bypassing the check

- The user with **uid 1** always bypasses the plagiarism check.
- You can add further **roles** to the bypass list from the module's user/role
  configuration, so trusted editors are not slowed down by a check on every save.

## A note on cost and rate

Because each check consumes a Copyscape API request against your paid
subscription, be deliberate about which fields and content types you enable —
checking every field on every save can add up. Start with the content types where
originality actually matters.
