<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Utilities provides small utility features for AI, chiefly a Format service to normalise AI/LLM output such as converting markdown to HTML and trimming code fences.

---

Install the module; it exposes the ai_utilities.format service (class Drupal\ai_utilities\Format). Other modules inject or call the service to detect HTML, convert markdown to HTML, and trim wrapping fences from model responses.

---

- Provide a Format helper service for AI output.
- Detect whether a string is HTML (isHtml).
- Convert markdown text to HTML (markdownToHtml).
- Trim wrapping code fences from responses (trim).
- Expose the ai_utilities.format service.
- Offer a FormatInterface for typing/DI.
- Serve as a developer utility for AI modules.
- Require no routes or permissions.
- Make no external/network calls itself.
- Normalise LLM responses before display.
- Depend on no other contrib modules.
- Be reused by other AI integrations.
- Keep formatting logic in one place.
- Handle ```html style fenced blocks.
- Provide static helper methods.
- Have no configuration UI.
- Work on Drupal 10.
- Act purely as a support library.
