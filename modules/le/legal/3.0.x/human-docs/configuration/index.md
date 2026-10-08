# Configuration

Setting up Legal is a two-step job: **enter your terms**, then **choose how they are
shown and enforced**. This page covers both, plus the permissions.

## Entering your Terms & Conditions

Go to **Configuration → People → Legal** (`/admin/config/people/legal`). You need
the **Administer Terms and Conditions** permission. Type or paste your terms into
the text area and choose a display style, then save.

**Every save creates a new version.** That matters: publishing a new version is what
forces existing users to accept again on their next login. So save deliberately —
each save is a new revision in your compliance history.

Two optional extras live on this form:

- **Extra checkboxes** — up to ten additional required tick-boxes, each with its own
  label (for example "I am at least 18 years of age"). Every one must be ticked
  before the account is created.
- **Changes** — a short explanation of what changed since the last version, shown to
  returning users as they are asked to re-accept.

## Display and behaviour settings

Open the **Settings** sub-tab (`/admin/config/people/legal/settings`). The options:

- **Terms display style (registration)** and **Terms display style (login)** —
  choose how the terms are presented, separately for the registration form and the
  login/profile context. The four styles are:
  - **Scroll box** — a plain, read-only scrollable box.
  - **Scroll box (CSS)** — the same, styled with the module's scroll CSS.
  - **HTML text** — the terms rendered inline as formatted HTML.
  - **Page link** — the Accept label links to the terms, optionally opening them in
    a modal dialog.
- **Collapsible container** — for each of registration and login, whether to wrap the
  terms in a collapsible details element.
- **Show on profile edit** — whether the terms (and a re-acceptance requirement)
  also appear on the user profile edit page.
- **Require acceptance on every login** — off by default. When on, users must accept
  the terms at *every* login, not only when a new version is published. Use this for
  high-compliance sites.
- **Exempt roles** — select roles that are never required to accept (for example
  staff). User 1 and masquerading sessions are always exempt regardless of this
  setting.
- **Open terms in a modal** — when the display style is *Page link*, whether the
  link opens the terms in a modal dialog (available separately for registration and
  login).
- **Login redirect URL** — where to send a user after they accept the terms during
  login.

On a multilingual site, the **Languages** sub-tab
(`/admin/config/people/legal/languages`) lets you keep separate terms text per
language.

## The public terms page, token, and reports

- **`/legal`** renders the current Terms & Conditions to anyone with the **View Terms
  and Conditions** permission.
- The **`[legal:tc]`** token outputs the current terms, so you can embed them in
  other content or emails.
- Two Views reports ship with the module: a **T&C History** report of past versions
  and an **Accepted** report of who accepted what. Both are ordinary Views, so you
  can adjust their columns and filters.

## Permissions

On **People → Permissions** you will find:

- **Administer Terms and Conditions** — manage the terms text and the settings.
- **View Terms and Conditions** — see the public `/legal` page.

## Saving

Each form saves with its own **Save** button. Remember that saving the terms text
itself bumps the version and triggers re-acceptance, whereas saving the settings form
only changes display and behaviour.
