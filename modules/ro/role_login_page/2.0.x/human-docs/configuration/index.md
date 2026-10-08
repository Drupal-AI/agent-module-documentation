# Configuration

You configure this module by creating one or more **login pages**, each with its own
path and its own per-role destination. Users then visit the login path that suits
them and are routed to the right place after signing in.

## Open the settings list

1. Log in as a user with the **Administer role login settings**
   (`administer role login settings`) permission.
2. Go to **Administer → Configuration → Role login settings → Role login settings
   list** (the `role_login_page.settings_list` route).

## Add a login page

1. Click **Add login page**.
2. Give the page a **path** — this becomes the URL of that login form (for example a
   staff entrance or a member entrance).
3. Set the **destination(s)** — where a user should land after authenticating,
   according to their role. This is what makes a "staff" login send editors to the
   dashboard while a "member" login sends members to the member area.
4. Save.

Repeat for each audience that needs its own entrance. Once saved, visit the login
path you defined, sign in, and confirm you are redirected to the destination you
configured.

## Keep destinations in configuration

Define every destination here in the settings rather than passing it through a
request parameter. A destination that comes from configuration is safe; one taken
from untrusted input on the URL would be an open-redirect risk. Keeping the
destinations in the form is what makes this feature safe to use.

## Remember what this does — and does not — do

These login pages change **where users land**, not **who may authenticate**. All the
forms validate against the same accounts, so anyone with valid credentials can sign
in at any of your login pages. If you need to prevent certain accounts from logging
in at a particular entrance entirely, combine this with a domain or IP restriction,
or use a separate site — this module alone will not enforce that separation.
