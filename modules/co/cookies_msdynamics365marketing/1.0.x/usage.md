Bridges Microsoft Dynamics 365 Marketing's client-side "Anonymize" tracking flag to visitor cookie consent collected by the COOKiES consent banner.

---

COOKiES MS Dynamics 365 Marketing Anonymize is a small sub-integration for the COOKiES Consent Management module. It does not add, load, or block any Dynamics 365 Marketing form or tracking script — you still embed those yourself as usual. Its sole job is to toggle Dynamics 365's documented client-side `Anonymize` flag according to whether the visitor has granted consent for the module's tracking service. It registers one COOKiES service (id `msdynamics365marketing`, in the `tracking` group) so the service appears in the consent banner with its cookie table, and it attaches a JavaScript behavior on every page that listens for the COOKiES `cookiesjsrUserConsent` event. Before consent (the default) it defines a global `d365mktConfigureTracking()` returning `{Anonymize: true}`; once consent is given it returns `{Anonymize: false}` and, if the Dynamics runtime is present, calls `MsCrmMkt.reconfigureTracking({Anonymize: false})`. It requires the COOKiES (`cookies`) module and supports Drupal 9, 10, and 11. The maintainers describe it as very specific and work in progress.

---

- Load Dynamics 365 Marketing forms/tracking in an anonymized state until the visitor opts in.
- Un-anonymize Dynamics 365 tracking the moment consent is granted through the COOKiES banner.
- Re-anonymize (fall back) when consent is denied or later revoked.
- Add a "MS Dynamics 365 Marketing" service entry to the COOKiES consent banner automatically.
- Present visitors a ready-made cookie table (the four Dynamics 365 tracking cookies) in the banner.
- Group the Dynamics 365 consent toggle under the banner's "tracking" category.
- Keep Dynamics 365 Marketing usage GDPR / ePrivacy consent-compliant.
- Avoid setting non-essential Dynamics 365 cookies before opt-in.
- Implement Microsoft's official "disable non-essential Dynamics 365 Marketing cookies" guidance in Drupal.
- Define the global `d365mktConfigureTracking()` helper Dynamics 365 forms read at load time.
- Call `MsCrmMkt.reconfigureTracking()` live when a visitor changes their consent choice.
- Wire consent handling without writing any custom JavaScript.
- Reuse the site's existing COOKiES banner rather than a separate consent tool.
- Anonymize marketing tracking for anonymous and authenticated visitors alike.
- Attach the consent behavior site-wide via `hook_page_attachments` (no block placement needed).
- Let editors keep embedding Dynamics 365 forms in content exactly as before.
- Provide a console test (`d365mktConfigureTracking()`) to verify the flag returns the expected value.
- Support marketing teams running Dynamics 365 campaigns on a consent-first Drupal site.
- Centralize Dynamics 365 consent behavior in one enable-and-forget module.
- Pair with the COOKiES module to cover an additional third-party marketing tool.
