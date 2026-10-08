Bothive Chatbot embeds the third-party bothive.be chatbot widget into a Drupal site and lets an administrator configure its API key, visibility and target pages.

---

The module registers a `hook_page_attachments()` implementation that, on every page, attaches the external Bothive widget script (`https://widget.bothive.be`) and a small init library, then hands the configured API key plus the `logging` and `hidden` flags to the browser through `drupalSettings`. A single admin form (`Administration » Configuration » System » Bothive`, route `bothive.configuration`, permission `administer bothive configuration`) stores four settings in the `bothive.configuration` config object: the API key, a logging toggle, a hidden toggle, and a Drupal core `request_path` visibility condition. The widget only initialises when the request-path condition matches the current page and the API key is non-empty. You must have a Bothive account, a valid API key (Bothive Dashboard » Settings » General), and the site's domain whitelisted in Bothive for the chatbot to actually render. The module ships no server-side API calls, entities, services beyond one controller, or webhooks — it is purely a client-side widget loader.

---

- Add the bothive.be chatbot to a Drupal site without writing any custom template or JavaScript.
- Paste a Bothive API key into a settings form instead of hand-editing a `<script>` tag in a theme.
- Show the chatbot site-wide by leaving the request-path pages field empty.
- Restrict the chatbot to a set of pages (e.g. `/contact`, `/support/*`) using the request_path condition.
- Invert page targeting with the "negate" option to show the bot everywhere except listed pages.
- Load the widget in a hidden state so it initialises but does not display until your own JS opens it.
- Trigger the chatbot open/close from custom JavaScript by combining the hidden option with the Bothive widget API.
- Enable the logging option to print informative Bothive init logs to the browser console while debugging.
- Diagnose a non-appearing chatbot by turning on logging and reading console errors (per the module README).
- Delegate chatbot configuration to a specific role by granting only `administer bothive configuration`.
- Provide first-line customer support/live chat on marketing or landing pages.
- Add an automated FAQ / triage bot to a support section of a site.
- Run the free Bothive tier for basic chatbot features on a low-traffic site.
- Keep the chatbot off admin routes by targeting only front-end paths in the request_path condition.
- Deploy the same chatbot configuration across environments by exporting the `bothive.configuration` config.
- Swap the chatbot to a different Bothive workspace by changing just the API key value.
- Temporarily disable the widget everywhere by clearing the API key (empty key = nothing attached).
- Use the module on Drupal 8.8 through 11 sites since it declares broad core compatibility.
- Integrate lead-capture / appointment flows built in Bothive into a Drupal front end.
- Add a chatbot to a multisite where each site uses its own whitelisted domain and API key.
- Combine with Drupal's permissions UI so editors cannot change the chatbot API key.
