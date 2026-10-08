# Configuration

All of Multiple Registration lives under **Configuration → People → Multiple
registration pages** (`/admin/config/people/multiple_registration`). Every admin
page here requires the **Administer multiple registration** permission
(`administer multiple_registration`).

## The admin pages

| Page | Path | Purpose |
|------|------|---------|
| **Multiple registration pages** (main list) | `/admin/config/people/multiple_registration` | Lists your registration pages, with links to create, edit, delete, and the settings sub-pages. |
| **Add / edit a page** | `.../{role}/add` | Create or edit the registration page for a role. |
| **Delete a page** | `.../{role}/remove` | Remove a role's registration page. |
| **Settings** | `.../settings` | Global options (below). |
| **Access settings** | `.../access_settings` | Which pages anonymous users may reach. |

The generated signup form for each role lives at `/user/register/{role}`
(reachable via your chosen alias).

## Create a registration page

1. From the main list, choose the target role and click to add its page.
2. Set the fields:
   - **Registration page path** — the friendly URL alias, e.g. `/vendor-signup`.
   - **Redirect path** *(optional)* — where to send the new user after they
     submit the form, e.g. a role-specific welcome page.
   - **Form mode (register)** — the user form mode used to render this
     registration form, so you can show role-specific fields.
   - **Form mode (edit)** — the form mode used when the user later edits their
     account.
   - **Hide registration form tab** — when ticked, the page is reachable only by
     its direct URL (no visible tab), useful for invitation-only signups.
3. Save. The page becomes available at `/user/register/{role}`, aliased to your
   path, and a matching path alias is created for you. Anyone who registers there
   is granted that role.

## Global settings

On the **Settings** sub-page (`.../settings`):

- **Disable the main registration page** — turns off the default
  `/user/register`, forcing users to choose a role-specific page instead.
- **Redirect logged-in users to their profile** — sends already-authenticated
  visitors who land on a registration page to their own profile rather than
  showing them a signup form.
- **Add "Add user" buttons on the People page** — adds per-role quick-create
  buttons to the admin People listing, so staff can create a user of a given role
  in one click.

## Access settings

On the **Access settings** sub-page (`.../access_settings`) you choose **which
registration pages anonymous visitors are allowed to reach**. Use this to keep
some role signups private (staff-created only) while leaving others open to the
public.

## Show or require fields per role

Multiple Registration can make specific profile fields appear — or be required —
only on certain roles' registration forms. On a field's own settings (in the user
entity's *Manage fields*), the module adds options to select which roles a field
is **shown for** and which roles it is **required for**. This lets you keep, say,
a "Company name" field on the vendor signup form only, without cluttering other
registration pages.
