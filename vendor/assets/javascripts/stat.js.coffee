new Morris.Line(

  # ID of the element in which to draw the chart.
  element: "stat-chart"

  # Chart data records -- each entry in this array corresponds to a point on
  # the chart.
  data: [
    {
      year: "2008"
      value: 20
    }
    {
      year: "2009"
      value: 10
    }
    {
      year: "2010"
      value: 5
    }
    {
      year: "2011"
      value: 5
    }
    {
      year: "2012"
      value: 20
    }
  ]

  xkey: "year"
  ykeys: ["value"]
  labels: ["Value"]
)