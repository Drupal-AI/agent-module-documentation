ECA Webprofiler adds an "ECA" panel and toolbar item to the Webprofiler developer toolbar so you can see, per request, the ECA log messages and the token/data values ECA had available.

---

ECA Webprofiler is a small developer/debugging integration between the ECA (Event-Condition-Action) automation module and the Webprofiler module. It registers a Symfony `data_collector` (service `webprofiler.eca`, class `EcaDataCollector`) and decorates ECA's `logger.channel.eca` logger channel with `ConfigurableLoggerChannel`. When the "ECA" toolbar item is enabled in Webprofiler, every message ECA logs during a request is captured together with a recursively expanded dump of the ECA token data (entities, users, events, forms, Data Transfer Objects and scalar values) that was available at that moment. The captured data appears as a "Log entries" count in the toolbar and as a "Debugging" table (step message plus its tokens) in the profiler panel, letting a developer follow which ECA steps ran and what data flowed between them. The module ships no routes, permissions, configuration, libraries or Drush commands of its own; it is reached entirely through Webprofiler's own permission-gated profiler UI and is intended for development and staging environments only.

---

- Debug why an ECA model did or did not fire on a given request by reading the captured ECA log entries.
- See the ordered sequence of ECA steps that executed during a page load, in the profiler "Debugging" table.
- Inspect the ECA token/data values (entity, user, event, form, DTOs, scalars) available at each logged step.
- Check the "Log entries" count in the Webprofiler toolbar to gauge how much ECA activity a request triggered.
- Confirm which entity (type/bundle/id/label) ECA was operating on when a step logged a message.
- Verify that a token name you reference in an ECA action actually resolves to the expected value.
- Diagnose Data Transfer Object (DTO) contents, including when DTO properties are unavailable ("properties not available").
- Trace data passed between chained ECA actions across a single request.
- Compare ECA execution between two requests by opening each request's stored profile.
- Investigate ECA-driven form alterations by inspecting the `form` token data at the point of logging.
- Understand why a conditional ECA branch was skipped by examining the values it read.
- Review the exact token identifiers (e.g. `%eca_token_<name>`) ECA exposed, as listed in the panel.
- Onboard onto an unfamiliar site's ECA configuration by watching what fires during normal browsing.
- Validate that a newly built ECA model behaves as designed before enabling it in production.
- Spot ECA steps that unexpectedly run on many requests, contributing to overhead.
- Use the profiler's request history to audit ECA behaviour across a sequence of admin actions.
- Enable or disable ECA capture per environment by toggling the "eca" toolbar item in Webprofiler settings.
- Keep ECA debugging output out of the general watchdog/dblog while still inspecting it via the profiler.
- Teach developers how ECA's token system populates data by showing real values in context.
- Confirm ECA event data (the `event` token) reaching an action matches the triggering event.
