Webform Share lets any webform be embedded on external websites via an iframe or a small JavaScript snippet, rendering the form standalone (without your site's theme chrome) for cross-site distribution.

---

Sometimes a form built in Drupal needs to live on a completely different website — a partner's page, a static marketing microsite, or a CMS you don't control. Webform Share exposes each webform through shareable endpoints: a bare "share page" at `/webform/{webform}/share` rendered by a dedicated theme negotiator so it carries no site navigation, and a `share.js` script that injects the form (as an iframe) into any host page. Site builders get an admin **Share** tab at `/admin/structure/webform/manage/{webform}/share` that produces ready-to-copy iframe and JavaScript embed code, plus preview and test screens. The module ships event subscribers and a page display-variant subscriber so the shared render is isolated from the main theme, and route subscribers wire the share routes onto both webforms and webform nodes. Because embedding is enabled per webform (via the webform's third-party/access settings), you control exactly which forms are shareable. Submissions from embedded forms are recorded normally against the source webform.

---

- Embed a Drupal webform on an external partner website via iframe.
- Distribute a signup form to microsites you don't fully control.
- Copy ready-made iframe embed code from the admin Share tab.
- Copy a JavaScript (`share.js`) snippet that injects the form.
- Render a form standalone without the site's header/footer theme.
- Preview how the shared form looks before publishing embed code.
- Test the shared form in isolation via the share test page.
- Put the same form on multiple third-party pages at once.
- Collect submissions from external sites into one central webform.
- Share a contact form across a network of brand sites.
- Embed a lead-capture form in a marketing landing page builder.
- Provide an event registration widget to sponsor websites.
- Offer an application form that partners can drop into their site.
- Keep form logic and results centralized in Drupal while displaying anywhere.
- Share webform-node forms as well as standalone webforms.
- Serve the shared form under an isolated theme/display variant.
- Version the embedded JS library via the share library route.
- Restrict which forms are embeddable per webform.
- Reuse one survey across many external campaigns.
- Provide donation or subscription forms to affiliate sites.
