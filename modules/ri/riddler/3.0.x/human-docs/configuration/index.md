# Configuration

Setting up Riddler is two steps: create one or more riddles, then attach the
Riddler challenge to the forms you want to protect. Both are done with CAPTCHA's
**Administer CAPTCHA settings** permission.

## 1. Create and manage riddles

Go to **Configuration → People → CAPTCHA → Riddler**
(`/admin/config/people/captcha/riddler-riddle`). This lists your riddles, showing
each one's question, solution, hint and status, and warns you that page caching is
only fully compatible with a single riddle.

Click **Add riddle** and fill in:

- **Question** — the prompt shown to the visitor as the CAPTCHA field's label (for
  example "What is our town's name?").
- **Solution** — the accepted answer. To accept several answers, list them
  **comma-separated** — for example `Springfield,springfield` or `4,four`.
- **Hint** *(optional)* — shown as the field's description to help genuine visitors.
- **Status** — enabled or disabled. Only enabled riddles are ever shown; disabling a
  riddle keeps it around without using it.

Riddles are translatable and are stored as configuration, so they can be exported
and deployed across environments. You can edit or delete any riddle from the list.

## 2. Attach the Riddler challenge to a form

Riddler only *provides* the challenge — you choose where to use it in CAPTCHA's own
settings:

1. Go to **Configuration → People → CAPTCHA** (`/admin/config/people/captcha`).
2. Add a **CAPTCHA point** for the form you want to protect (identified by its form
   ID — for example the user registration or contact form), and set its challenge
   type to **Riddler**. Alternatively, set Riddler as the site-wide default
   challenge.

CAPTCHA then renders a random enabled riddle on that form. On submit, Riddler checks
the visitor's answer against the comma-separated solution list, honouring CAPTCHA's
global case-sensitivity setting (set on the main CAPTCHA settings page).

## Caching, once more

- **Exactly one** enabled riddle → protected forms remain fully cacheable.
- **Two or more** enabled riddles → Riddler disables the page cache on protected
  forms so a fresh random riddle appears on each request.

If page caching on your protected forms is important, keep a single enabled riddle.
Otherwise, several riddles make it harder for a bot to hard-code one answer.
