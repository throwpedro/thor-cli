# ===========================
# thor-cli cross-platform Justfile
# ===========================
app := "thor"
dist := "dist"

set windows-shell := ["powershell", "-Command"]

# ---------------------------
# Default recipe (help)
# ---------------------------
default:
    @just --list

# ---------------------------
# Build for current OS
# ---------------------------
build:
    go build -o {{app}}

# ---------------------------
# Build Windows binary
# ---------------------------
[windows]
windows:
    $env:GOOS='windows'; $env:GOARCH='amd64'; go build -o {{app}}.exe

[unix]
windows:
    GOOS=windows GOARCH=amd64 go build -o {{app}}.exe

# ---------------------------
# Build macOS binary
# ---------------------------
[windows]
mac:
    $env:GOOS='darwin'; $env:GOARCH='amd64'; go build -o {{app}}

[unix]
mac:
    GOOS=darwin GOARCH=amd64 go build -o {{app}}

# ---------------------------
# Build Linux binary
# ---------------------------
[windows]
linux:
    $env:GOOS='linux'; $env:GOARCH='amd64'; go build -o {{app}}

[unix]
linux:
    GOOS=linux GOARCH=amd64 go build -o {{app}}

# ---------------------------
# Build all binaries into dist/
# ---------------------------
[windows]
build-all:
    New-Item -ItemType Directory -Force -Path {{dist}} | Out-Null
    $env:GOOS='windows'; $env:GOARCH='amd64'; go build -o {{dist}}/{{app}}-windows-amd64.exe
    $env:GOOS='darwin';  $env:GOARCH='amd64'; go build -o {{dist}}/{{app}}-darwin-amd64
    $env:GOOS='linux';   $env:GOARCH='amd64'; go build -o {{dist}}/{{app}}-linux-amd64

[unix]
build-all:
    mkdir -p {{dist}}
    GOOS=windows GOARCH=amd64 go build -o {{dist}}/{{app}}-windows-amd64.exe
    GOOS=darwin  GOARCH=amd64 go build -o {{dist}}/{{app}}-darwin-amd64
    GOOS=linux   GOARCH=amd64 go build -o {{dist}}/{{app}}-linux-amd64
