---
layout: page
title: research
permalink: /research/
nav: true
nav_order: 2
---

Our research is dedicated to solving the most critical security challenges of the digital age. We explore the theoretical limits and design practical defense mechanisms across three topics.

---

### 1. The Intersection of AI & Cybersecurity

Artificial Intelligence has fundamentally reshaped the landscape of cybersecurity. Our research explores this duality: leveraging AI as a powerful shield for **defense**, while simultaneously analyzing how AI can be weaponized for **offense** (such as automated attacks and password cracking).

#### AI-Empowered Threat Detection (AI for Defense)
Traditional signature-based defenses struggle against zero-day attacks and rapidly mutating malware. We utilize advanced AI models to identify malicious events that evade conventional detection.
* **Intelligent Malware Analysis:** We employ **Few-Shot Learning** and deep learning techniques to detect malicious code variants, even those using advanced obfuscation.
* **Anomaly Detection:** Using unsupervised learning to monitor network traffic and user behavior, enabling early identification of intrusion attempts before they cause damage.

#### AI-Assisted Attacks & Vulnerabilities (AI for Offense)
To build better defenses, we must understand the attacker's capabilities. We research how AI accelerates offensive operations, focusing on:
* **AI-Driven Password Analysis:** We investigate how generative models (such as GANs or LLMs) can be used to simulate intelligent **password guessing** attacks, predicting user password patterns more efficiently than traditional brute-force methods.
* **LLM Security Risks:** We analyze how Large Language Models (like ChatGPT) can be manipulated via **Prompt Injection** or misused to generate **polymorphic malware**, allowing us to develop countermeasures against these AI-generated threats.

#### Adversarial Machine Learning (Robustness)
While AI is powerful, it is also fragile. As discovered by Szegedy et al. (2013), adding imperceptible perturbations to an image—known as an **Adversarial Example**—can cause high-precision AI models to fail catastrophically. We analyze these mathematical vulnerabilities to build robust models that remain secure even when under active mathematical attack.

---

### 2. Modern & Applied Cryptography

Cryptography is the bedrock of trust in the digital world. Our research spans the entire spectrum: from designing mathematical primitives to implementing secure protocols for critical infrastructures.

#### Theoretical Cryptography: Design & Provable Security
We focus on the rigorous mathematical design and security analysis of advanced cryptographic primitives.
* **Identity-Based Encryption (IBE):** We investigate techniques that simplify key management by allowing a user's public identity (e.g., email address) to serve directly as their public key.
* **Searchable Encryption (SE):** We design schemes that allow servers to search over encrypted data without decrypting it, balancing search efficiency with strict privacy guarantees.
* **Provable Security:** ensuring that our proposed schemes are mathematically secure against defined adversarial models.

#### Applied Cryptography: Protocols & Infrastructure
We bridge the gap between theory and practice by securing real-world systems.
* **Public Key Infrastructure (PKI) & Digital Identities:** We focus on securing the backbone of modern authentication, including government-issued Digital IDs and certificate management.
* **Internet of Vehicles (IoV) Security:** Designing lightweight and secure authentication protocols for V2X (Vehicle-to-Everything) communications to prevent forgery and unauthorized access in autonomous driving networks.

#### Post-Quantum Cryptography (PQC)
The rise of quantum computing poses an existential threat to current encryption standards (like RSA and ECC). To protect national security and long-term data confidentiality, we are actively researching **Post-Quantum Cryptography**.
* **Lattice-based Cryptography:** We design and evaluate lattice-based algorithms, which have been adopted as official standards (e.g., NIST PQC) due to their efficiency and strong security guarantees against quantum attacks.

---

### 3. Privacy-Preserving Technologies

To enable secure AI training and data analysis, we focus on three core technologies that allow computation on sensitive data without leaking information:

#### Differential Privacy (DP)
DP provides a rigorous mathematical definition of privacy by injecting calibrated noise into datasets. We research how to apply DP mechanisms to machine learning models  ensuring that the output of a model reveals nothing about any specific individual's data.

#### Secure Multi-Party Computation (MPC)
MPC enables multiple parties (such as different hospitals or financial institutions) to jointly compute a function over their inputs while keeping those inputs private. Our research focuses on optimizing MPC protocols to facilitate secure **Federated Learning**, allowing organizations to collaborate on model training without ever sharing raw data.

#### Fully Homomorphic Encryption (FHE)
Often considered the "Holy Grail" of cryptography,  FHE allows for arbitrary computation directly on encrypted data without decrypting it first. We are working on accelerating FHE operations (like lattice-based schemes) to make it practical for cloud-based AI inference, ensuring that the cloud server never sees the user's plaintext queries.
