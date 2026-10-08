# Configuration

Setting up Mentions is a two-step job: enable the filter on the text formats
where you want mentions to work, then (optionally) customize the input and output
patterns.

## Step 1 — Enable the Mentions filter on a text format

Mentions is delivered as an **input filter**, and a filter only runs on the text
formats you switch it on for.

1. Log in as a user with the **Administer filters** permission (an administrator
   by default).
2. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
3. Click **Configure** on the format you want mentions in (for example *Basic
   HTML* or *Full HTML* — commonly the format your comments and posts use).
4. Under **Enabled filters**, tick the **Mentions** filter.
5. Mind the **filter processing order** at the bottom of the form. As with any
   filter, the order in which filters run can affect the result, so if mentions
   do not render as expected, revisit the order relative to other filters.
6. Click **Save configuration**.

Repeat for each text format that should support mentions.

Once enabled, editors can type `[@username]` or `[@#uid]` in any field using that
format, and the filter converts it to a link such as `@username` pointing at the
user's profile.

## Step 2 — Customize the mention patterns

The mention settings form lets you tailor both what editors type and what the
site displays.

1. Go to **`/admin/config/content/mentions`**.
2. Adjust the **input pattern** — the form editors type, such as `[@username]`
   and `[@#uid]`.
3. Adjust the **output pattern** — how a resolved mention is rendered, such as
   `@username`. Output patterns support **Tokens**, so (with the Token module
   installed) you can build richer link text.
4. Save the form.

## Rendering and safety

Because a mention originates in user-authored content, the important thing is
that mentions render as **safe, escaped links**. Confirm on your own site that:

- A mention renders as a plain, escaped link — a user cannot inject markup
  through a mention pattern.
- Mentioning respects **user visibility** — resolving a mention should not
  disclose the existence of an account a viewer could not otherwise see.

Test these with a non-administrator account before relying on mentions in
production.

## Optional integrations

- **Views** — build a page listing all mentions, or mentions filtered by user,
  from the mention records the module stores.
- **Rules** — react to mentions being created, updated, or deleted (for example,
  to notify the mentioned user).
- **Machine name field** — can be used as a mention source instead of the
  username.
