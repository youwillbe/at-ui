# 1. 几个核心抽象

## `Core.Page`

```elm
type Page model msg
    = Page
        { init : () -> ( model, Effect msg )
        , update : msg -> model -> ( model, Effect msg )
        , subscriptions : model -> Sub msg
        , view : model -> View msg
        }
```

一个页面还是经典的四个函数，但基于额外的包装类型 `Effect` 和 `View`

## `Core.View`

```elm
type alias View msg =
    { title : String
    , body : List (Html msg)
    }
```

其实也可以直接像下面这样：

```elm
type alias View msg =
    Document msg
```

# 2. 要注意的几个点

- 路由和应用的分形不一定一致
- 也就是说第一阶段是把Url解析为路由
