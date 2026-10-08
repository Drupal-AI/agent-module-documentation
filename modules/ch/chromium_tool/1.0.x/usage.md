Chromium Tool wraps a headless Chrome/Chromium browser as a Drupal screenshotter service and as an AI function-call tool that captures a PNG screenshot of a given URL.

---

Chromium Tool integrates the `chrome-php/chrome` library so that Drupal can drive a real headless Chromium browser on the server. It ships a `ChromiumScreenshotter` service with two capture modes — above-the-fold (viewport only) and full-page (measures the rendered document and clips to its full width/height) — that return raw PNG bytes. On top of that it registers an AI function call (`chromium_tool:screenshot_webpage`, from `drupal/ai`) so an AI agent or assistant can take a screenshot of a URL and receive a base64-encoded PNG plus metadata. A settings form lets a site administrator set the absolute path to the Chromium binary and optionally pick an image style to post-process every screenshot; the module also installs a ready-made "Chromium Tool Max 1500" image style that scales captures down to a 1500px bound. The module depends on `drupal/ai` and core `image`.

---

- Give an AI agent the ability to "look at" a live webpage by taking a screenshot of a URL.
- Capture an above-the-fold (viewport-sized) PNG of a public web page for an assistant to describe.
- Capture a full-page PNG (entire scroll height and width) of a page for archival or review.
- Let an AI chatbot fetch a visual of a competitor or reference site during a conversation.
- Generate marketing/QA screenshots of your own site's pages on demand from an agent workflow.
- Feed a rendered screenshot into a multimodal LLM for visual question answering.
- Produce thumbnails of external landing pages, downscaled through the bundled 1500px image style.
- Standardize screenshot dimensions by applying any site image style to every capture.
- Set a custom viewport width/height so responsive layouts are captured at a chosen breakpoint.
- Add an extra wait after page load so late-loading JS/images are present before the shot.
- Call the `ChromiumScreenshotter` service from custom code to embed screenshots in reports.
- Build a scheduled job that screenshots key pages and stores the PNG bytes returned by the service.
- Point the module at a distro-specific Chromium path (e.g. `/usr/bin/chromium`) via the settings form.
- Run the browser with `noSandbox` enabled so it works inside typical container/CI environments.
- Integrate visual page capture into an AI agent's "browsing tools" group of function calls.
- Provide an assistant a tool to verify that a deployed page renders correctly.
- Capture a PNG for documentation screenshots without a manual browser step.
- Return screenshot output as a compact JSON payload (`mime`, `encoding`, `data`, dimensions, `mode`, `url`).
- Post-process captures (scale, crop) by selecting an existing Drupal image style in configuration.
- Let editors preview how an external URL looks by exposing the tool through an AI assistant.
- Compare above-the-fold vs. full-page renders of the same URL by switching the `mode` argument.
