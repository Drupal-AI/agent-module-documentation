# AMP Analytics (analytics_amp) — agent index

Hidden submodule of [Analytics API](../../../../1.0.x/agent/start.md). Adds two `analytics_service`
plugins that emit only on AMP routes. Depends on `analytics` and the contrib `amp` module. No
settings route of its own — configured as services at `/admin/config/services/analytics`.

Key facts:
- `amp_analytics` (`AmpAnalytics`, `multiple`): config `type` (Adobe/Google), `config_url`
  (remote JSON), `config_json` (inline JSON, validated); builds `<amp-analytics>` via
  `ServicePluginBase::getAmpOutput()` when `router.amp_context->isAmpRoute()`.
- `amp_tracking_pixel` (`AmpTrackingPixel`, `multiple`): required `url` (AMP var substitutions);
  emits `<amp-pixel src>` on AMP routes.
- No config schema file in this submodule; outputs nothing on non-AMP routes.
- Plugin framework: [../../../1.0.x/agent/plugins/analytics-service.md](../../../../1.0.x/agent/plugins/analytics-service.md).
