# ...


```bash
go get -u ./...
go mod tidy
go mod graph | grep echo
mkdir -vp var/
go build -o var/
ls -lh var/example-coopnorge-go-datadog-lib
strings var/example-coopnorge-go-datadog-lib | grep echo
```

```console
$ go get -u ./...
$ go mod tidy
$ go mod tidy
$ go mod graph | grep echo
example.com/example-coopnorge-go-datadog-lib github.com/labstack/echo@v3.3.10+incompatible
github.com/coopnorge/go-datadog-lib@v1.0.3-0.20221121084640-7965e52e4d17 github.com/labstack/echo@v3.3.10+incompatible
gopkg.in/DataDog/dd-trace-go.v1@v1.43.1 github.com/labstack/echo@v3.3.10+incompatible
gopkg.in/DataDog/dd-trace-go.v1@v1.43.1 github.com/labstack/echo/v4@v4.2.0
$ mkdir -vp var/
$ go build -o var/
$ ls -lh var/example-coopnorge-go-datadog-lib
-rwxr-xr-x 1 iwana iwana 13M Nov 21 11:54 var/example-coopnorge-go-datadog-lib
$ strings var/example-coopnorge-go-datadog-lib | grep echo
*echo.HTTPError
github.com/labstack/echo
dep	github.com/labstack/echo	v3.3.10+incompatible	h1:pGRcYk231ExFAyoAjAfD85kQzRJCRI8bbnE7CX5OEgg=
github.com/labstack/echo.NewHTTPError
github.com/labstack/echo.init
type..eq.github.com/labstack/echo.HTTPError
/home/iwana/go/pkg/mod/github.com/labstack/echo@v3.3.10+incompatible/echo.go
dep	github.com/labstack/echo	v3.3.10+incompatible	h1:pGRcYk231ExFAyoAjAfD85kQzRJCRI8bbnE7CX5OEgg=
github.com/labstack/echo.NewHTTPError
github.com/labstack/echo.init
type..eq.github.com/labstack/echo.HTTPError
github.com/labstack/echo..inittask
github.com/labstack/echo.ErrUnsupportedMediaType
github.com/labstack/echo.ErrNotFound
github.com/labstack/echo.ErrUnauthorized
github.com/labstack/echo.ErrForbidden
github.com/labstack/echo.ErrMethodNotAllowed
github.com/labstack/echo.ErrStatusRequestEntityTooLarge
github.com/labstack/echo.ErrTooManyRequests
github.com/labstack/echo.ErrBadRequest
github.com/labstack/echo.ErrBadGateway
github.com/labstack/echo.ErrInternalServerError
github.com/labstack/echo.ErrRequestTimeout
github.com/labstack/echo.ErrServiceUnavailable
github.com/labstack/echo.ErrValidatorNotRegistered
github.com/labstack/echo.ErrRendererNotRegistered
github.com/labstack/echo.ErrInvalidRedirectCode
github.com/labstack/echo.ErrCookieNotFound
```
