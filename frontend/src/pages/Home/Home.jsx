import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import axios from 'axios';
import PromotionsBanner from '../../components/PromotionsBanner/PromotionsBanner';
import './Home.css';

const Home = () => {
  const [products, setProducts] = useState([]);
  const [categories, setCategories] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchCategories = async () => {
      try {
        setLoading(true);
        const categoriesRes = await axios.get("/api/categories/public"); // Fetch only active categories
        setCategories(categoriesRes.data);
      } catch (err) {
        console.error("Error fetching categories:", err);
        setError("Failed to load categories. Please try again later.");
      } finally {
        setLoading(false);
      }
    };

    fetchCategories();
  }, []);


  if (loading) {
    return <></>;
  }

  if (error) {
    return <div className="home-error">{error}</div>;
  }

  // Process categories from database
  const displayCategories = categories.map(category => ({
    id: category.category_id,
    name: category.name,
    description: category.description || '',
    imageUrl: category.image 
  }));

  return (
    <div className="home-container">
      {/* Promotions Banner */}
      <PromotionsBanner />
      
      {/* Hero Section */}
      <section className="hero-section">
        <h1>Tech Excellence</h1>
        <p>✨ Premium tech, Smarter living, Welcome to TechStock ✨</p>
        <Link to="/products" className="explore-button">
          Explore Collection
        </Link>
      </section>

      {/* Product Categories Section */}
      <div className="categories-container">
        {displayCategories.length > 0 ? (
          displayCategories.map((category) => (
            <div key={category.id} className="category-card">
              <div className="image-container">
                <img src={category.imageUrl} alt={category.name} />
              </div>
              <div className="text-container">
                <h2>{category.name}</h2>
                <p>{category.description}</p>
                <Link to={`/products?category=${category.name}`} className="explore-link">
                  Explore {category.name}
                </Link>
              </div>
            </div>
          ))
        ) : (
          <div className="no-categories">
            <p>No categories available at the moment.</p>
          </div>
        )}
      </div>
    </div>
  );
};

export default Home;