# Architecture Plan — SwiftChart

**Date:** 2026-07-10
**Based on:** MVP Scope v1.0 (reverse-engineered)
**Migration source:** Existing codebase, migrated to Agentic setup by `migrate-existing-project`

> This document was reverse-engineered from an existing codebase. It describes the
> architecture **as it exists after migration**, not a plan written before development.
> Any decision that was inherited from the pre-existing project (rather than freshly
> decided during migration) is marked "Inherited" in the ADR table below.

---

## Project Identity

- **Name:** SwiftChart
- **Platforms:** iOS
- **Scale:** Open-source library, solo-maintained

---

## Component Structure

| Folder | Purpose |
|--------|---------|
| `Source/` | The `SwiftChart` library target (Chart, ChartSeries, ChartColors) |
| `Tests/SwiftChartTests/` | Unit test target for the library |
| `demo/` | Demo iOS app consuming `SwiftChart` as a local SPM package |
| `docs/` | Documentation, ADRs, design specs |

---

## Tech Stack

| Component | Stack | Architecture Pattern |
|-----------|-------|---------------------|
| `Source/` (spm) | Swift, UIKit, Swift Package Manager | None — small procedural `UIControl` subclass, no MVVM/TCA/etc. |
| `demo/` | Swift, UIKit, Storyboards, XcodeGen | None — `UIViewController` per demo screen (Basic, Stock, Table), no shared architecture pattern |

---

## Testing Strategy

| Component | Enabled Test Types |
|-----------|-------------------|
| `Source/` (spm) | Unit Tests (starter scaffold added during migration; no Snapshot/UI tests) |
| `demo/` | None (no test targets on the demo app) |

---

## Third-Party Dependencies

| Category | Tool | Notes |
|----------|------|-------|
| Analytics | none | |
| Crash reporting | none | |
| Authentication | none | |

---

## Infrastructure

| Item | Decision | Details |
|------|----------|---------|
| GitHub Project | Yes | Views: Roadmap, Board, Backlog |
| GitHub Actions CI | Yes | Components: spm (build+test), demo (build check) |
| Fastlane | Yes | Components: spm (`test` lane) |
| API Hosting | N/A | No API component |
| Promo Web Hosting | N/A | No promo web component |

### Fastlane Details

| Field | Value |
|-------|-------|
| Bundle ID | N/A (library has no bundle id; demo app is `com.marekloose.SwiftChartDemo`) |
| Apple Developer Team ID | 9JVYUSJU3D |
| App Store Connect App ID | N/A — library is not distributed via App Store; demo app is not published |
| Xcode scheme | `SwiftChart` (package), `SwiftChartDemo` (demo app) |
| TestFlight internal group | N/A |
| Crash reporting tool | none |

---

## Migration Notes

| Old Path | New Path | Notes |
|----------|----------|-------|
| `Example/` | `demo/` | Renamed per convention for an SPM package's demo app |
| `Example/SwiftChart.xcodeproj` + `.xcworkspace` | `demo/SwiftChartDemo.xcodeproj` | Regenerated via XcodeGen from a new `demo/project.yml`; old hand-maintained project deleted after a successful build |
| `Example/Podfile`, `Podfile.lock`, `Pods/` | *(removed)* | CocoaPods dependency on `SwiftChart` replaced with a local SPM package dependency in `demo/project.yml` |
| N/A | `Tests/SwiftChartTests/` | New starter unit test target added to `Package.swift` (package previously had zero tests) |
| N/A | `docs/` | New — reverse-engineered documentation created by this migration |

Bundle id for the demo app changed from `org.gpbl.SwiftChart-Example` (belonging to the
original upstream author, gpbl) to `com.marekloose.SwiftChartDemo`. Deployment target bumped
from iOS 8.3 to iOS 18.0 to match the library's actual current minimum.

---

## ADRs

| # | Title | Decision | Origin |
|---|-------|----------|--------|
| ADR-000 | Migrate to Agentic Setup | Restructure project to the standard Agentic layout (docs/, project.yml, Fastlane, GitHub Actions) | New |
| ADR-001 | Demo App Uses Local SPM Package Dependency | Replace CocoaPods-based demo dependency with a local SPM package reference | New |
| ADR-002 | iOS-only, UIKit-based Chart View | Library is a `UIControl` subclass with no cross-platform abstraction | Inherited |

---

## Notes

The library ships a `SwiftChart.podspec` for CocoaPods distribution pointing at the original
upstream repo (`github.com/gpbl/SwiftChart`). This migration does not touch the podspec —
whether CocoaPods distribution is still desired for this fork is flagged as an Open Question
in `docs/product/mvp-scope.md`.
