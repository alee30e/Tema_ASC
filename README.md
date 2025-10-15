# Storage Device Manager

This project is part of a minimal operating system and is implemented in **x86 Assembly**.  
It simulates how an OS manages a **storage device** (hard drive or SSD) — storing, deleting, and rearranging files.

---

## Features

The program supports **two modes**:

### 1. One-Dimensional Memory
- Total storage: **8 MB**, divided into **8 KB blocks**  
- Each file occupies contiguous blocks (at least two)  
- Supported operations:
  - Allocate space for a file (first available continuous area)
  - Show which blocks a file occupies
  - Delete a file and free its blocks
  - Defragment the storage (move files together to remove gaps)

### 2. Two-Dimensional Memory
- Storage is organized as a **2D grid** (8MB × 8MB)  
- Files are stored contiguously along rows  
- Supported operations:
  - Allocate space for a file in the grid
  - Show the coordinates ((startX, startY), (endX, endY)) of a file
  - Delete a file
  - Defragment the grid (move empty spaces to the bottom-right corner)

---

## Goal

This project is a simple **simulation** of how an operating system could manage file storage, focusing on allocation, deletion, and defragmentation — all implemented in **x86 Assembly**.
