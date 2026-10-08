# Configuration

Setting up Book Access Code has two parts: creating the codes that unlock a book,
and (optionally) customizing the text on the page where visitors enter a code.
You also need to understand the two permissions that govern who can manage codes
and who bypasses the gate.

## Permissions

Set these under **People → Permissions** (`/admin/people/permissions`):

- **Administer access codes** (`administer access codes`) — lets a role create,
  edit and delete access codes. Grant it only to trusted administrators.
- **Bypass book access code checks** (`bypass book access code checks`) — any
  role with this permission skips the gate and always sees protected books.
  Administrators typically hold this; be deliberate about who else does.

## Create and manage access codes

1. Go to **Structure → Book → Access code**
   (`/admin/structure/book/access_code`).
2. Add a new access code, tying it to the book you want to protect and giving it
   the code value visitors must enter. You can create **multiple valid codes for
   the same book** — useful for handing different codes to different groups.
3. Save. From here you can also edit or delete existing codes.

A book is only gated once it has at least one active code. Books with no codes
are unaffected and display normally.

## Set the access‑page text

The page visitors land on to enter a code (`/book_access`) has customizable
description text:

1. Go to `/admin/config/system/book_access_code/settings`.
2. Edit the description shown on the code‑entry page — for example, instructions
   telling readers where to get a code.
3. Save.

## How visitors experience it

When someone opens a page in a gated book and their session does not already hold
a valid code, they are redirected to the `/book_access` form. After entering a
correct code, the grant is stored in their session and they can browse that book
without being asked again. Codes are matched with strict typing, so they are not
bypassed by loose type comparisons.

## Important limitation

The gate is enforced on the **canonical book node route** only — the normal page
view. Content served through **JSON:API, REST or Views is not covered** by this
module. If a book must remain genuinely private, do not rely on Book Access Code
as the sole protection; also restrict those other access channels.
