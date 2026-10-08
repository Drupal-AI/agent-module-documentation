Hidden submodule of Analytics API that adds two analytics_service plugins for AMP pages — a configurable `<amp-analytics>` tag and an `<amp-pixel>` tracking pixel — that only emit on AMP routes.

---

`analytics_amp` provides two `@AnalyticsService` plugins (both `multiple = true`), and depends on `analytics` plus the contrib `amp` module. **AMP Analytics** (`amp_analytics`, `AmpAnalytics`) has a `type` select (Adobe Analytics / Google Analytics), a `config_url` (remote configuration JSON URL) and a `config_json` textarea (inline JSON, validated by `ServicePluginBase::validateJson()`); its `getOutput()` checks `router.amp_context` `isAmpRoute()` and, when true, builds an `<amp-analytics>` element via the base `getAmpOutput()` (embedding the JSON config in a `application/ld+json` script and setting `type`/`config` attributes). **AMP Tracking Pixel** (`amp_tracking_pixel`, `AmpTrackingPixel`) has a single required `url` (supporting AMP variable substitutions like `RANDOM`) and, on AMP routes, emits an `<amp-pixel src="…">` element. Both plugins output nothing on non-AMP routes. There is no config schema file in this submodule. All configuration is via the standard analytics service UI and is behind `administer analytics`.

---

- Add an `<amp-analytics>` tag to AMP pages for Google or Adobe Analytics.
- Configure AMP analytics from a remote JSON configuration URL.
- Provide inline JSON configuration for amp-analytics.
- Add an AMP tracking pixel (`<amp-pixel>`) to AMP routes.
- Use AMP variable substitutions (e.g. RANDOM) in a tracking pixel URL.
- Ensure analytics only load on AMP routes, not regular HTML pages.
- Run multiple AMP analytics/pixel instances (`multiple` plugins).
- Manage AMP analytics alongside non-AMP services in one UI.
- Inherit DNT and admin-route suppression from the parent module.
- Enable/disable AMP analytics without deleting configuration.
- Export AMP analytics configuration as deployable config.
- Serve AMP-compliant analytics without hand-writing AMP components.
- Combine an amp-analytics tag and a tracking pixel on the same site.
- Validate inline AMP JSON config at save time.
- Restrict who configures AMP analytics via `administer analytics`.
