
## Core Lexicon Web-App

Core Lexicon Analysis is a discourse assessment originally developed by
Dalton & Richardson (2015) that measures the typicality of words used in
a semi-structured discourse task. This web-app is intended to facilitate
efficient and accurate core lexicon scoring for both research and
clinical practice.

## Feedback

At this stage, we would appreciate feedback on the app - whether related
to bugs/issues with the app or requested features. Please provide
feedback or report bugs using the issues tab in the github repository.

## About Core Lexicon Analysis

CoreLex checklists have been developed for a variety of widely used
discourse tasks (including picture description, picture sequence, story
retell, procedures, and unfamiliar narrative production) have been
developed using large samples of healthy control speakers (Dalton et
al., 2020). CoreLex is a micro-linguistic measure which provides
information about word retrieval and lexical access in connected speech
samples. CoreLex checklists consist of lemmas that are scored as either
present (1) or absent (0), which makes scoring very simple.

CoreLex has shown good sensitivity in differentiating between controls
and individuals with aphasia (Dalton & Richardson, 2015; Fromm et al.,
2017), between individuals with fluent and non-fluent aphasia (Kim et
al., 2019; Kim et al., 2021), and between aphasia subtypes (Dalton &
Richardson, 2015; Fromm et al., 2017). Studies have also demonstrated
that CoreLex is related to standardized measures of aphasia (Kim et al.,
2019, Kim et al., 2021), other discourse measures (Alyahya et al., 2021;
Dalton & Richardson, 2019; Kim & Wright, 2020) and picture naming
(Alyahya et al., 2021). Preliminary evidence also suggests that corelex
might be sensitive to treatment-induced changes in some PWA (Dalton et
al., 2020; Dede & Hoover, 2021).

## About this web-app

Briefly, the app works by converting an orthographic transcription into
tokens, finding the lemma associated with each token, and matching these
lemmas with established core lexicon checklists. The user is asked to
double check that no core lexicon targets were missed, or identified in
error. A percentile score is then calculated using norms reported by
\[REFERENCE\]. The app is written in the {shiny} framework. The app is
currently in Beta, and is not yet ready for research or clinical
deployment. Please note, the app does not save any data from each user
session.

## References
