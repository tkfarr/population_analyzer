module Report
  def self.msa_avgs_over_years(zip_code)
    Msa.find_by_sql("
      SELECT
        name,
        (pop_estimate_2010 + pop_estimate_2011 + pop_estimate_2012 + pop_estimate_2013 + pop_estimate_2014 + pop_estimate_2015) / 6 AS avg_pop,
        (pop_change_2010 + pop_change_2011 + pop_change_2012 + pop_change_2013 + pop_change_2014 + pop_change_2015) / 6 AS avg_pop_change_blah,
        (births_2010 + births_2011 + births_2012 + births_2013 + births_2014 + births_2015) / 6 AS avg_births,
        (deaths_2010 + deaths_2011 + deaths_2012 + deaths_2013 + deaths_2014 + deaths_2015) / 6 AS avg_deaths,
        (natural_inc_2010 + natural_inc_2011 + natural_inc_2012 + natural_inc_2013 + natural_inc_2014 + natural_inc_2015) / 6 AS avg_natural_inc
      FROM msas
      JOIN cbsas_zip_codes ON msas.cbsa_id = cbsas_zip_codes.cbsa_id
      JOIN zip_codes ON zip_codes.id = cbsas_zip_codes.zip_code_id
      WHERE msas.lsad = 'Metropolitan Statistical Area'
      AND zip_codes.code = #{zip_code}
    ").first
  end

  def self.msa_natural_increase_in_county_vs_state(zip_code)
    Msa.find_by_sql("
      SELECT
        SPLIT_PART(name, ', ', 1) AS county,
        SPLIT_PART(name, ', ', 2) AS state,
        SUM(natural_inc_2010) AS county_natural_inc_2010,
        SUM(state_natural_inc_2010) AS state_natural_inc_2010,
        ROUND(SUM(natural_inc_2010) / SUM(state_natural_inc_2010) * 100::NUMERIC, 2) AS percent_of_state_2010,
        SUM(natural_inc_2011) AS county_natural_inc_2011,
        SUM(state_natural_inc_2011) AS state_natural_inc_2011,
        ROUND(SUM(natural_inc_2011) / SUM(state_natural_inc_2011) * 100::NUMERIC, 2) AS percent_of_state_2011,
        SUM(natural_inc_2012) AS county_natural_inc_2012,
        SUM(state_natural_inc_2012) AS state_natural_inc_2012,
        ROUND(SUM(natural_inc_2012) / SUM(state_natural_inc_2012) * 100::NUMERIC, 2) AS percent_of_state_2012,
        SUM(natural_inc_2013) AS county_natural_inc_2013,
        SUM(state_natural_inc_2013) AS state_natural_inc_2013,
        ROUND(SUM(natural_inc_2013) / SUM(state_natural_inc_2013) * 100::NUMERIC, 2) AS percent_of_state_2013,
        SUM(natural_inc_2014) AS county_natural_inc_2014,
        SUM(state_natural_inc_2014) AS state_natural_inc_2014,
        ROUND(SUM(natural_inc_2014) / SUM(state_natural_inc_2014) * 100::NUMERIC, 2) AS percent_of_state_2014,
        SUM(natural_inc_2015) AS county_natural_inc_2015,
        SUM(state_natural_inc_2015) AS state_natural_inc_2015,
        ROUND(SUM(natural_inc_2015) / SUM(state_natural_inc_2015) * 100::NUMERIC, 2) AS percent_of_state_2015
      FROM msas
      JOIN (
        SELECT
          SPLIT_PART(name, ', ', 2) AS state,
          SUM(natural_inc_2010) AS state_natural_inc_2010,
          SUM(natural_inc_2011) AS state_natural_inc_2011,
          SUM(natural_inc_2012) AS state_natural_inc_2012,
          SUM(natural_inc_2013) AS state_natural_inc_2013,
          SUM(natural_inc_2014) AS state_natural_inc_2014,
          SUM(natural_inc_2015) AS state_natural_inc_2015
        FROM msas
        WHERE msas.lsad = 'Metropolitan Statistical Area'
        AND SPLIT_PART(name, ', ', 2) IN (
          SELECT
            SPLIT_PART(name, ', ', 2)
          FROM msas
          JOIN cbsas_zip_codes ON msas.cbsa_id = cbsas_zip_codes.cbsa_id
          JOIN zip_codes ON zip_codes.id = cbsas_zip_codes.zip_code_id
          WHERE msas.lsad = 'Metropolitan Statistical Area'
          AND zip_codes.code = #{zip_code}
        )
        GROUP BY state
      ) state_totals ON state_totals.state = SPLIT_PART(name, ', ', 2)
      WHERE SPLIT_PART(name, ', ', 1) IN (
        SELECT
          SPLIT_PART(name, ', ', 1)
        FROM msas
        JOIN cbsas_zip_codes ON msas.cbsa_id = cbsas_zip_codes.cbsa_id
        JOIN zip_codes ON zip_codes.id = cbsas_zip_codes.zip_code_id
        WHERE msas.lsad = 'Metropolitan Statistical Area'
        AND zip_codes.code = #{zip_code}
      )
      GROUP BY 1, 2
    ").first
  end

  def self.msa_data_by_county_for_state(zip_code)
    Msa.find_by_sql("
      SELECT
        SPLIT_PART(name, ', ', 1) AS county,
        SPLIT_PART(name, ', ', 2) AS state,
        msas.*
      FROM msas
      WHERE msas.lsad = 'Metropolitan Statistical Area'
      AND SPLIT_PART(name, ', ', 2) IN (
        SELECT
          SPLIT_PART(name, ', ', 2)
        FROM msas
        JOIN cbsas_zip_codes ON msas.cbsa_id = cbsas_zip_codes.cbsa_id
        JOIN zip_codes ON zip_codes.id = cbsas_zip_codes.zip_code_id
        WHERE msas.lsad = 'Metropolitan Statistical Area'
        AND zip_codes.code = #{zip_code}
      )
    ")
  end

  def self.state_totals(zip_code)
    Msa.find_by_sql("
      SELECT
        SPLIT_PART(name, ', ', 2) AS state,
        SUM(pop_estimate_2010) AS state_pop_estimate_2010,
        SUM(pop_estimate_2011) AS state_pop_estimate_2011,
        SUM(pop_estimate_2012) AS state_pop_estimate_2012,
        SUM(pop_estimate_2013) AS state_pop_estimate_2013,
        SUM(pop_estimate_2014) AS state_pop_estimate_2014,
        SUM(pop_estimate_2015) AS state_pop_estimate_2015,
        SUM(pop_change_2010) AS state_pop_change_2010,
        SUM(pop_change_2011) AS state_pop_change_2011,
        SUM(pop_change_2012) AS state_pop_change_2012,
        SUM(pop_change_2013) AS state_pop_change_2013,
        SUM(pop_change_2014) AS state_pop_change_2014,
        SUM(pop_change_2015) AS state_pop_change_2015,
        SUM(births_2010) AS state_births_2010,
        SUM(births_2011) AS state_births_2011,
        SUM(births_2012) AS state_births_2012,
        SUM(births_2013) AS state_births_2013,
        SUM(births_2014) AS state_births_2014,
        SUM(births_2015) AS state_births_2015,
        SUM(deaths_2010) AS state_deaths_2010,
        SUM(deaths_2011) AS state_deaths_2011,
        SUM(deaths_2012) AS state_deaths_2012,
        SUM(deaths_2013) AS state_deaths_2013,
        SUM(deaths_2014) AS state_deaths_2014,
        SUM(deaths_2015) AS state_deaths_2015,
        SUM(natural_inc_2010) AS state_natural_inc_2010,
        SUM(natural_inc_2011) AS state_natural_inc_2011,
        SUM(natural_inc_2012) AS state_natural_inc_2012,
        SUM(natural_inc_2013) AS state_natural_inc_2013,
        SUM(natural_inc_2014) AS state_natural_inc_2014,
        SUM(natural_inc_2015) AS state_natural_inc_2015
      FROM msas
      WHERE msas.lsad = 'Metropolitan Statistical Area'
      AND SPLIT_PART(name, ', ', 2) IN (
        SELECT
          SPLIT_PART(name, ', ', 2)
        FROM msas
        JOIN cbsas_zip_codes ON msas.cbsa_id = cbsas_zip_codes.cbsa_id
        JOIN zip_codes ON zip_codes.id = cbsas_zip_codes.zip_code_id
        WHERE msas.lsad = 'Metropolitan Statistical Area'
        AND zip_codes.code = #{zip_code}
      )
      GROUP BY state
    ").first
  end
end
