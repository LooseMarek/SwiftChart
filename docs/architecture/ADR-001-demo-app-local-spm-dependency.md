# ADR-001 — Demo App Uses Local SPM Package Dependency

**Date:** 2026-07-10
**Status:** Accepted
**Author:** Architect
**Deciders:** Marek Loose

---

## Context

The pre-existing `Example/` (now `demo/`) app depended on the library through CocoaPods
(`pod "SwiftChart", :path => "../"`), with a vendored `Pods/` directory checked into git. The
library itself is distributed primarily as a Swift Package (`Package.swift` at the repo root).
Regenerating the demo project via XcodeGen (the one exception this migration makes for
regenerating Apple project configuration) was an opportunity to also simplify the dependency
wiring.

---

## Decision

The demo app now declares `SwiftChart` as a local Swift Package dependency
(`packages: { SwiftChart: { path: .. } }` in `demo/project.yml`), and the CocoaPods artifacts
(`Podfile`, `Podfile.lock`, `Pods/`, the old `.xcodeproj`/`.xcworkspace`) were deleted.

---

## Options Considered

### Option 1: Local SPM package dependency (chosen)

**Description:** Reference the root package directly via a relative path in `project.yml`.

**Pros:**
- No separate package manager or vendored dependency directory to maintain
- Matches how the library is actually distributed and how most consumers will use it
- One fewer toolchain (no `pod install` step) needed to build the demo

**Cons:**
- Demo no longer exercises the CocoaPods distribution path

### Option 2: Keep CocoaPods

**Description:** Leave `Podfile`/`Pods/` as-is, only add `project.yml` alongside it.

**Pros:**
- Continues to validate the CocoaPods distribution channel end-to-end

**Cons:**
- Vendored `Pods/` in git is unusual and adds churn/noise to diffs
- Requires CocoaPods installed in CI in addition to Swift toolchain

---

## Rationale

The library's primary and current distribution channel is SPM; the demo app's job is to
exercise the package during development, not to validate every possible distribution
mechanism. A local SPM dependency is simpler to maintain and matches the actual `Package.swift`
at the repo root.

---

## Consequences

**Positive:**
- Demo app builds directly against the in-repo library source with no separate install step
- Removes ~20 vendored `Pods/` files from git

**Negative / Trade-offs:**
- CocoaPods distribution (`SwiftChart.podspec`) is no longer exercised by any part of this repo's
  build/test process — if CocoaPods support is still important, it should be validated
  separately (see the open question in `docs/product/mvp-scope.md`)

**Risks:**
- None — verified via a successful `xcodebuild build` before deleting the old setup

---

## Related

| Type | Reference |
|------|-----------|
| Supersedes | |
| Related ADRs | ADR-000 |
| Related issues | |
