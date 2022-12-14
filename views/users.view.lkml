view: users {
  sql_table_name: `looker-private-demo.thelook.users`
    ;;
  drill_fields: [ created_week, count]

  dimension: id {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  measure: count {
    type: count
    drill_fields: [id, last_name, first_name, orders.count, order_items.count, full_name]
  }

  dimension: days_since_signup {
    type: number
    sql: DATE_DIFF(current_date, ${created_date}, day) ;;
  }

  dimension: is_new_user{
    description: "users that have signed up in the past 30 days"
    type: yesno
    sql: ${days_since_signup} <= 30 ;;
  }

  measure: new_user_count {
    description: "Count of users that have signed up in the past 30 days"
    type: count
    filters: [is_new_user: "yes"]
  }


  dimension: full_name{
    type: string
    sql: ${first_name} || " " || ${last_name} ;;
  }

}
