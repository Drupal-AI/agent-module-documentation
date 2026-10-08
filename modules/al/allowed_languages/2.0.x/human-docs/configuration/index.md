# Configuration

Allowed Languages has no settings form. You configure it in two steps:
set the permissions, then assign languages on each user account.

## 1. Set the permissions

Go to **People → Permissions** (`/admin/people/permissions`) and find the two
permissions this module adds:

- **Administer allowed languages** — who may **see and set** the "Allowed
  languages" field on user profiles. Give this to administrators (and anyone who
  manages editorial staff). On its own it does *not* let a user bypass the
  language restriction.
- **Translate all languages** — the **bypass**. Anyone holding it is exempt from
  every restriction: they can edit, delete, and translate content in all
  languages, their create‑form language selector is never pruned, and the
  translations overview keeps all its links. Grant this only to trusted leads and
  super‑editors who genuinely need to work in every language.

There is **no** permission that switches the restriction on. Restriction is the
default for every user who lacks *Translate all languages*. That means:

- A restricted user with **some** languages assigned can manage content only in
  those languages.
- A restricted user with **no** languages assigned is effectively blocked from
  editing or deleting any translatable content and from managing translations.

A typical setup: give your editors the relevant core **content translation**
permissions, assign each one a subset of languages (next step), and give
*Translate all languages* only to admins.

## 2. Assign allowed languages to a user

1. Go to **People**, click **Edit** on the user you want to scope.
2. Find the **Allowed languages** section (visible only to users who hold
   *Administer allowed languages*).
3. Tick each language the user may manage content in. There is also an **Allow all
   languages** checkbox as a shortcut to grant every configured language at once.
4. **Save** the user.

Repeat for each editor. For example, tick only **German** for your German editor
and only **French** for your French editor, so each can work solely within their
own language.

## 3. What the restriction covers

Once languages are assigned, the module enforces them automatically:

- **Editing and deleting** existing content in a disallowed language is forbidden.
- **Translation management** (add / edit / delete a translation) is limited to
  permitted target languages.
- The **translations overview** page hides operation links for disallowed
  languages.
- The **language selector** on new‑content forms drops disallowed languages (this
  one is a display‑time convenience, not a hard server check).

## 4. (Optional) Scope content listings with the Views filter

The module provides a Views filter called **Current user's allowed languages**.
Add it to any View of a translatable entity to show each editor only the content
in their allowed languages — a good way to build a per‑editor content dashboard.

- Add it under the View's **Filter criteria**.
- It **cannot be exposed** to end users; it always filters by the *current* user's
  assigned languages.
- If the current user has no languages assigned, the filter adds no restriction
  (the View is left unfiltered), so combine it with your permission setup as
  intended.

The same filter is registered for both the main data table and the revision data
table of every translatable content entity type, so it works on revision listings
too.
