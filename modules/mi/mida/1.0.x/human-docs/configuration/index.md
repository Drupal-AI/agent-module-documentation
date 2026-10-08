# Configuration

Mida A/B Testing is configured on the module's **Mida settings** form (under
**Configuration**, reachable by a user with the *Administer site configuration*
permission). The settings tell the module which Mida account to load and where
the experimentation script should run.

## Mida API key

Paste the **API key** from your Mida account. This is the required setting — it
links the injected snippet to your experiments. Without a valid key, the script
has nothing to load. Treat the key as an account identifier for the external Mida
service.

## Anti‑flickering

Leave **anti‑flickering** support enabled to prevent the "flash of original
content" — the brief moment where a visitor sees the unmodified page before a
test variant is applied. This is the recommended default for any A/B test that
changes visible content.

## Visibility conditions

Decide **where** the Mida script loads rather than injecting it site‑wide. The
module lets you scope loading by:

- **Pages** — restrict to (or exclude) specific paths.
- **Roles** — load only for certain user roles.
- **Languages** — limit to particular site languages.
- **Content types** — load only on nodes of chosen content types.

Use these to keep the experimentation script off admin pages, editorial screens,
or any area where you don't want tests running.

## Script loading

The Mida script is loaded **asynchronously** so it doesn't block page rendering —
this is handled by the module and is the intended behaviour for performance.

## Save and verify

Save the form, then load a page that matches your visibility conditions and view
its source: the Mida snippet should be present. If it isn't, re‑check that the API
key is set and that the page actually matches the visibility conditions you chose.

## Privacy reminder

Because Mida loads a third‑party script that can modify pages and may set cookies
or collect visitor data, make sure its use is disclosed in your privacy policy
and, where required, only loads after the visitor has given consent — combine the
visibility conditions above with your site's consent tooling as needed.
