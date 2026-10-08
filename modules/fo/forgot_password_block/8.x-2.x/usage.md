<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Forgot Password Block exposes Drupal core's password-reset request form as a placeable block, so the "forgot password" form can appear in any region instead of only at /user/password.

---

The password-reset request form normally lives on its own page at /user/password. Putting it in a login area, a sidebar, a modal, or a footer means it can sit right where users are when they realise they cannot log in. Forgot Password Block provides one block plugin (id `forgot_password_block`, admin label "Forgot Password", category "Forms") whose `build()` method returns the core form `Drupal\user\Form\UserPasswordForm` via the form builder. It adds no form, no route, no permission, and no settings of its own: what renders is exactly the core reset-request form, so it inherits core's markup, validation, CSRF token, flood control, and the generic "if the account exists, instructions have been sent" confirmation. Install it, place the block from the Block Layout UI, and set the block's standard visibility/region options. Depends only on the core User and Block modules; works on Drupal 8, 9, 10, and 11.

---

- Place the password-reset request form as a block in any theme region.
- Add a "forgot your password?" form directly to a custom login page or panel.
- Show the reset form in a sidebar next to the login block.
- Render the reset form inside a modal or off-canvas tray.
- Put the reset form in the site footer for quick recovery.
- Add reset to a decoupled/landing page built with Block Layout.
- Avoid sending users away to /user/password by embedding the form inline.
- Combine the login block and this reset block in one login region.
- Use core's standard reset form without writing a custom form or route.
- Keep core's built-in flood control on password-reset attempts.
- Keep core's generic anti-enumeration confirmation message.
- Restrict where the block appears using the block's visibility conditions (pages, roles, content type).
- Show the block only to anonymous users via role visibility.
- Provide password recovery on an intranet or members area page.
- Give a multi-step or wizard theme a reset step as a block.
- Support Drupal 8 through 11 sites needing an embeddable reset form.
- Offer reset from a "having trouble?" support block.
- Place reset near a custom SSO/login integration for local accounts.
- Enable the module only while the feature is needed and uninstall otherwise.
- Theme the block region without altering the core form itself.
- Add the reset form to a maintenance or help page.
- Keep the setup minimal: enable, place, save.
