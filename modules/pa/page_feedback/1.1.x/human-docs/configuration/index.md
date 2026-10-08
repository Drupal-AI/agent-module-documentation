# Configuration

Page Feedback has **no central settings page**. Everything you can tune lives on
the **block placement**, plus two permissions that decide who can read and export
responses. If you leave the wording fields empty, the block uses its shipped,
translatable defaults — so this whole page is optional.

## Open the block's Wording panel

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Place a new **Page feedback** block (category *Content*), or click **Configure**
   on one you have already placed.
3. In the block configuration form, open the **Wording** section.

Each field is optional and capped at 255 characters. Leave a field empty (or fill
it only with spaces) to keep the module's default, which stays translatable. A
value you type here replaces the default in every language for this placement —
the module does not translate it, but the block itself can be translated through
**Configuration Translation** if you need per‑language wording.

## Wording fields

- **Question** — the text shown above the Yes/No choice. Default:
  *"Was this page helpful?"*
- **Comment box label after "Yes"** — the label above the comment box a visitor
  sees after choosing Yes. Default: *"Tell us more"*.
- **Comment box label after "No"** — the label above the comment box shown after
  choosing No. Default: *"How can we improve this page?"* A "No" answer requires a
  non‑empty comment, so a low score always arrives with a reason.
- **Notice** — the text under both comment boxes. Default: *"You will not receive a
  reply. Don't include personal information."* The reminder *"Up to 1000
  characters."* is always appended automatically and cannot be removed.

The thank‑you confirmation and the Send button label are not configurable, but
both are translatable.

> **Tip:** Because the wording is per placement, you can put two Page feedback
> blocks on different sections of the site with different questions.

Click **Save block** when you are done. The new wording takes effect immediately.

## Permissions

Set these under **People → Permissions** (`/admin/people/permissions`):

- **View page feedback** (`view page feedback`) — browse and filter collected
  responses without being able to change anything.
- **Administer page feedback** (`administer page feedback`) — full access,
  including single and bulk deletion and CSV export. This is a **restricted**
  permission, so grant it only to trusted roles. The CSV export route additionally
  requires a valid CSRF token, which the admin UI supplies for you.

## Reviewing and exporting responses

Responses appear at **Content → Page feedback** (`/admin/content/page-feedback`),
25 per page, newest first. Filter by helpful/not‑helpful state and by URL, delete
entries individually or with the bulk action, and use **Export** to download the
currently filtered list as a CSV.

A cron task cleans up obvious SQL‑injection‑probe spam automatically (at most once
a day), so you do not need to schedule anything yourself.
