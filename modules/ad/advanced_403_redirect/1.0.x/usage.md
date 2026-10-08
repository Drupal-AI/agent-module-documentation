Advanced 403 Redirect turns individual access-denied (403) responses into redirects to an admin-chosen page.

---

Advanced 403 Redirect lets administrators define per-path rules that replace the default 403 "access denied" page with a redirect. Each rule is an `access_denied_url` content entity storing a source URL, a destination URL and an optional message. When a non-administrator requests a path whose path-info matches a rule's source, an event subscriber (`AccessDeniedRedirectSubscriber::on403`, a kernel `KernelEvents::EXCEPTION` handler) issues an HTTP redirect to the destination and can flash the configured message as a warning. Source URLs are validated to point to an existing, unpublished entity; destination URLs are validated to start with a slash and resolve to a real local route. Rules are managed from a Views-based listing at `/admin/redirect-403-urls` with standard add/edit/delete entity forms.

---

- Send visitors who hit an unpublished node's 403 to a public listing page instead of the access-denied screen.
- Redirect a forbidden page to the site homepage.
- Redirect a restricted path to a login or "request access" page.
- Show a friendly "This content is no longer available" message on redirect.
- Replace Drupal's default 403 page on a per-path basis without a global override.
- Point retired or unpublished article URLs to a category or archive page.
- Keep would-be visitors on-site when they stumble onto access-restricted content.
- Guide anonymous users from a members-only page to a signup page.
- Map several unpublished product pages each to their own replacement URL.
- Preserve SEO/UX by 302-redirecting dead unpublished URLs to relevant live content.
- Configure redirects through a familiar entity add/edit form (Source Url, Destination Url, Message).
- Manage all rules from one Views table at `/admin/redirect-403-urls`.
- Add a new rule via the "Add access denied url" action link on the listing.
- Exempt administrators (users with the `administrator` role) from redirects so they still see the real 403.
- Display a per-rule status message to the visitor after redirecting.
- Enforce that a destination is a valid internal route before a rule can be saved.
- Enforce that a source resolves to an unpublished entity before a rule can be saved.
- Prevent duplicate rules for the same source path.
- Restrict who can create and edit rules with the `administer access denied url` permission.
- Integrate with Views so the rule listing can be themed, filtered and paged.
- Provide a lightweight alternative to writing a custom 403 exception subscriber by hand.
