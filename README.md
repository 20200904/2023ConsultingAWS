🛡️ AWS CLOUD PENTESTING WEBSITE


📌 Project Overview
This project involves the implementation of a web application and server environment on AWS to enhance understanding of web service operations and security. Following the "Guide for Vulnerability Diagnosis of Major Information and Communication Infrastructure," this project demonstrates the process of identifying, analyzing, and mitigating security vulnerabilities from an administrator's perspective.


🛠️ Technical StackFrontend: 
HTML, CSS, JavaScript Backend: Java (Servlet/JSP based) Database: MySQL (AWS RDS) Infrastructure: AWS EC2 (Ubuntu), AWS ACM (SSL/TLS) Analysis Tools: Burp Suite, Wireshark 


🚀 Key Features
User Management: Authentication, profile management, and secure session handling.
Board/Blog CMS: CRUD operations for posts, file uploads/downloads, and comment systems.
Security Controls: Input filtering, CSRF token validation, and DBMS access control.


📑 Vulnerability Diagnosis & Report Structure
This repository is based on a comprehensive security consulting report. The diagnosis covered 8 DBMS items and 17 Web application items, identifying a total of 19 vulnerabilities across the system.


1. Report Hierarchy
Introduction: Background, objectives, personnel roles, and diagnosis schedule.
Executive Summary: A high-level overview of the diagnosis results and general assessment.
DBMS Vulnerabilities: Detailed inspection and remediation of Account and Access Management.
Web Application Vulnerabilities: Analysis of 17 major attack vectors including Injection and Broken Access Control.
Advanced Vulnerability Analysis: In-depth exploitation scenarios for Command Injection, SSRF, SSTI, and Malware.
2. Major Diagnosis Items & Results
DBMS Security: Identified vulnerabilities in default password policies (D-01), password reuse limits (D-12), and remote access restrictions (D-05).
Web Application Security:
Injection:Analyzed SQL Injection (SI) and OS Command Injection (OC) risks.Broken Access Control: Diagnosed insufficient authentication (IA) and authorization (IN).Cross-Site Attacks: Verified Stored/Reflected XSS (XS) and CSRF (CF) vulnerabilities.File Handling: Tested for malicious Web Shell uploads (FU) and Path Traversal during downloads (FD).Information Leakage: Identified exposure of sensitive data in source code and verbose error page
