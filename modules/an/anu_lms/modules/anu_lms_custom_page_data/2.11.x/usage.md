Anu LMS Example: Custom page data is a developer example showing how to add custom data to Anu LMS lesson and courses-page payloads through events.

---

This example submodule (package "Anu LMS Examples") demonstrates the supported extension point for enriching the JSON payload that Anu LMS prints for its React front end. `CustomPageDataSubscriber` (`src/EventSubscriber/CustomPageDataSubscriber.php`) subscribes to `anu_lms_courses_page_data_generated` (`CoursesPageDataGeneratedEvent`) and `anu_lms_lesson_page_data_generated` (`LessonPageDataGeneratedEvent`). On each it reads the current page data with `$event->getPageData()`, appends an example key (`additional-example-data` / `lesson-example-data`), shows a status message via the messenger, and writes the data back with `$event->setPageData()`. Because these events fire inside the content-type plugins (`CoursesPage`, `CoursesLandingPage`, `ModuleLesson`) just before the payload is embedded, whatever a subscriber adds becomes available to the front-end app.

It is a copy-and-adapt template: enable it to see the mechanism, then implement your own subscriber in a custom module. It ships no config, routes, permissions or content.

---

- Learn the supported way to extend the Anu LMS decoupled payload.
- Add custom data to lesson pages via `LessonPageDataGeneratedEvent`.
- Add custom data to courses pages via `CoursesPageDataGeneratedEvent`.
- Inject computed or integration data (badges, entitlements, related links) into the front end.
- See how to read and write page data with `getPageData()` / `setPageData()`.
- Use as a scaffold for a project-specific event subscriber.
- Verify the events fire by watching the example status messages.
