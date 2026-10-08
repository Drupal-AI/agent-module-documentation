Aweber Block connects a Drupal site to the AWeber email-marketing platform over OAuth2 and exposes a placeable block whose form subscribes site visitors to selected AWeber lists.

---

Aweber Block is a lightweight integration built around one editable config object (`aweber_block.aweberblockconfig`), an admin settings form, an OAuth2 authorization/callback pair of routes, two services, and a single `aweber_block` Block plugin. An administrator enters the AWeber developer app's Client ID and Secret, the API base URL, the OAuth redirect and authorize URLs, and picks the application scopes, then walks the "Authorize site on Aweber" link to grant the site access; AWeber redirects back to `/aweber_block/getCode`, where the module exchanges the authorization code for an access/refresh token pair and stores them in config. Once connected, the `AweberManager` service reads the connected account and its lists from the AWeber REST API; the site builder places the "Aweber block", configures which of those lists it offers, and anonymous visitors submit their email through the block's form to be added as subscribers (with an existence check first, and an optional redirect to a thank-you/registration page after signup). The module targets Drupal 9/10/11, ships no submodule, no config schema, and no custom permissions (every admin route is gated by core's `access administration pages`).

---

- Connect a Drupal site to an AWeber account without writing any AWeber API code.
- Add a newsletter/list signup block to a page, sidebar, or footer.
- Let anonymous visitors subscribe their email to one or more AWeber lists.
- Offer visitors a choice of several AWeber lists to opt into from one block.
- Present a single fixed list for a focused newsletter signup.
- Redirect a visitor to a "thank you" page after they subscribe.
- Redirect a visitor to a custom internal registration/landing page after signup.
- Avoid duplicate subscriptions by checking whether an email already exists on the list before adding it.
- Configure the AWeber API base URL (e.g. `https://api.aweber.com/1.0`) per environment.
- Enter the OAuth2 authorize endpoint and the site's redirect URI from the settings form.
- Select which AWeber OAuth scopes (account/list/subscriber/email read and write) the site requests.
- Re-run the "Authorize site on Aweber" flow to re-connect or change the granted account/scopes.
- Automatically refresh the AWeber access token when the stored token has expired.
- Store the connected AWeber account ID so subscribe calls target the right account.
- Build a multi-list marketing signup form managed entirely from Drupal's block layout UI.
- Drive list membership from Drupal without exposing AWeber credentials to end users.
- Place multiple instances of the block, each offering a different set of lists, on different pages.
- Use the module's `AweberManager` service from custom code to fetch accounts, fetch lists, add subscribers, or check subscriber existence.
- Theme the post-signup thank-you output by overriding the `aweber_block` theme hook / `aweber-block.html.twig` template.
- Integrate list signup into a landing page campaign where AWeber runs the email automation.
