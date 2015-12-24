$(function() {
    $('.events-header .form-control').keyup(_.debounce(function (e) {
        $('.search-box').submit()
    }, 1000))

})