# Configuration

PRLP works the moment you enable it — the *Set New Password* field appears on the
reset landing page with no setup. This form just lets you tune two things.

## Open the settings form

1. Log in as a user with the **Administer PRLP settings** permission (this is a
   restricted permission the module adds; administrators have it by default).
2. Go to **Configuration → People → Account settings → PRLP**, or navigate
   directly to `/admin/config/people/accounts/prlp`.

The form has exactly two fields.

## Password Entry Required

A checkbox, **on by default**. When ticked, the visitor *must* enter and confirm a
new password on the reset landing page before continuing. Untick it to make the
new-password field optional — users can then simply log in via the reset link
without changing their password if they don't want to.

## Login Destination

A text field for the path the user is sent to after they log in via the reset
link. The default is `/user/%user/edit` (their own account edit page). You can
point it anywhere — an onboarding page, a dashboard, or the front page. Two tokens
are substituted for you:

- **`%user`** — replaced with the logged-in user's numeric user ID. For example,
  `/user/%user/edit` becomes `/user/42/edit` for user 42, and `/user/%user` lands
  them on their account page.
- **`%front`** — replaced with the site's configured front page.

The value is treated as an internal path (a leading `/` is added if you omit one).
If the path can't be resolved, PRLP logs the problem and falls back to the default
destination, then to the user page — so a typo won't strand anyone.

## Save

Click **Save configuration**. Changes apply to the next reset that comes through.

## Going further

Developers can change the destination per user with
`hook_prlp_login_destination_alter()`, and react to the reset via the module's two
events (`prlp.password_validate` and `prlp.password_before_save`) — the latter is
how the **PRLP Password Policy** submodule plugs the Password Policy rules into the
reset page. See the [`agent/`](../agent/start.md) references for those hooks and
events.
