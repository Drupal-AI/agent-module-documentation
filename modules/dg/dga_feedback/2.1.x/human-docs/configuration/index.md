# Configuration

Setting up DGA Feedback has four parts: placing the widget block, tuning its
behavior on the Settings page, translating its text, and assigning permissions so
the right people can view and moderate submissions.

## 1. Place the widget block

The feedback widget is a block, so it appears only where you place it.

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Add the **DGA Feedback Widget** block to the region you want (often below the
   main content).
3. Use the block's **Visibility** settings to limit where it appears — for
   example to specific content types or paths.
4. Save the block.

## 2. Configure widget behavior

Go to **DGA Feedback → Settings** (`/admin/config/dga-feedback/settings`). Here
you can adjust:

- **Widget refresh delay** — how many seconds the widget waits after a successful
  submission before resetting itself.
- **Rate limiting** — the maximum number of submissions allowed per IP address
  within a chosen time window, to curb abuse.
- **Length and count constraints** — limits on the length of free-text feedback
  and on the length and number of reasons.

Save the form to apply your changes.

## 3. Manage translations (English / Arabic)

Go to **DGA Feedback → Translations**
(`/admin/content/dga-feedback/translations`). Every visible string is provided as
a side-by-side English/Arabic pair, grouped into sections:

- **Closed state** — the question text, the Yes/No button labels, and the
  statistics template.
- **Feedback form** — the close button, the reasons title and instruction, the
  Yes and No reason lists (entered one per line), the feedback label and
  placeholder, and the gender labels (Male, Female, Prefer not to say).
- **Submitted state** — the success message.
- **Validation messages** — every inline error (Yes/No required, reason required,
  feedback required, submission failed, unknown error).
- **API & backend messages** — method not allowed, invalid JSON, rate limit,
  save failed, and the success message.
- **Menu items** — the titles of the DGA Feedback menu and its sub-items.

> **Tip:** Don't include parentheses in the reasons instruction field — the
> template adds them automatically. Changes save instantly, with no cache clear
> required.

## 4. Assign permissions

Go to **People → Permissions** (or edit a specific role) and assign the DGA
Feedback capabilities as appropriate:

- **view dga feedback dashboard** — view statistics and submissions without the
  ability to edit or delete them.
- **manage dga feedback submissions** — edit, delete, or bulk-delete
  submissions.
- **administer dga feedback settings** — change the widget configuration and
  translations.

Save the role to apply the changes.

## Privacy note

Because the widget can collect demographic data (gender) along with feedback,
handle stored submissions in line with your site's privacy policy — including how
long you retain them and who may view them.
