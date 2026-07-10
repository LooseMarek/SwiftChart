# MVP Scope — SwiftChart

**Version:** 1.0
**Date:** 2026-07-10
**Author:** Product Owner (reverse-engineered by migrate-existing-project)
**Status:** Draft

> This document was reverse-engineered from an existing codebase, not written before
> development started. It describes the product **as it exists today**, not as originally
> envisioned. Sections the exploration could not determine with confidence are flagged in
> Open Questions rather than guessed.

---

## Vision

A lightweight, dependency-free Swift Package for drawing line and area charts in iOS apps,
without pulling in a full charting framework.

---

## Problem Statement

iOS apps that need a simple line/area chart (e.g. showing a stock price or a trend over time)
either have to build custom `UIView` drawing code from scratch or take a dependency on a much
larger charting library. SwiftChart solves this for the common case: one or more series of
signed `Double` values, drawn as line or partially-filled area charts, with touch interaction.

---

## Target User

| Attribute | Detail |
|-----------|--------|
| Primary persona | iOS developers who need a small, embeddable chart view |
| Platform | iOS |
| Technical proficiency | Software engineers integrating a library into their own app |
| Key pain point | Full charting frameworks are heavyweight for a single line/area chart use case |
| Motivation to use this app | Drop-in `UIControl` subclass, configurable from Interface Builder or code |

---

## Value Proposition

Small surface area (three source files), no external dependencies, works from both
Interface Builder (`@IBDesignable`) and programmatically, and supports touch callbacks via
`ChartDelegate` — simpler to integrate than a general-purpose charting library.

---

## MVP Goals

1. Provide a `Chart` view that renders one or more `ChartSeries` as line or area charts.
2. Support both storyboard/IB-based and programmatic usage.
3. Ship as an installable Swift Package (and, historically, a CocoaPod).

---

## Success Metrics

| Metric | Target | Timeframe |
|--------|--------|-----------|
| Library builds and passes CI on push/PR | 100% green | Ongoing |
| Demo app builds against the local package | Green | Ongoing |

---

## In Scope (MVP)

- [x] Render one or more line/area series in a `Chart` view (`Source/Chart.swift`)
- [x] Configure series color, fill, and line width per-series (`Source/ChartSeries.swift`)
- [x] Predefined chart color palette (`Source/ChartColors.swift`)
- [x] Touch/drag interaction reporting the touched index and x-value via `ChartDelegate`
- [x] `@IBDesignable`/`@IBInspectable` support for configuring charts from Interface Builder
- [x] X/Y axis labels, grid lines, and label orientation (horizontal/vertical)
- [x] Distribution across the whole reachable width or per-fixed-interval segments
- [x] Swift Package Manager distribution (`Package.swift`, iOS 18.0+)

---

## Out of Scope (Post-MVP)

- macOS/watchOS/tvOS support (library currently imports `UIKit`, iOS-only)
- Additional chart types (bar, pie, scatter)
- SwiftUI-native chart view (current `Chart` is a `UIControl` subclass)

---

## Constraints

| Constraint | Detail |
|------------|--------|
| Timeline | Ongoing open-source maintenance, no fixed release schedule |
| Platform | iOS 18.0+ (per current `Package.swift`); demo app matches the same minimum |
| Monetisation | Free, open source (MIT license) |
| Dependencies | None at runtime |
| Known risks | UIKit-only — no macOS/visionOS support without a rewrite |

---

## Open Questions

- [ ] Is CocoaPods distribution (`SwiftChart.podspec`) still actively supported/published, or is
      SPM now the sole intended distribution channel? The podspec still points at
      `github.com/gpbl/SwiftChart` (the original upstream repo), not this fork.
- [ ] Is there an intended minimum deployment target lower than iOS 18.0 for library consumers,
      or was the bump to 18.0 (in the pre-migration commit "Bump iOS version") intentional as a
      hard cut?
- [ ] Are macOS/visionOS ports desired, or is this library intentionally iOS-only long-term?

---

## Approval

| Role | Name | Date | Status |
|------|------|------|--------|
| Product Owner | Marek Loose | 2026-07-10 | Draft |
| Architect | Marek Loose | 2026-07-10 | Draft |
